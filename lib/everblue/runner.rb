module Everblue
  class Runner
    class Example
      def initialize(row)
        @row = row
      end

      def passed?
        @row['passed']
      end

      def failure_message
        unless passed?
          msg = []
          msg << "  Failed: #{@row['name']}"
          msg << "    #{@row['message']}"
          msg << "    in #{@row['trace']}" if @row['trace']
          msg.join("\n")
        end
      end
    end

    class TestRunner
      attr_reader :runner, :test

      def initialize(runner, test)
        @runner = runner
        @test = test
      end

      def session
        runner.session
      end

      def io
        runner.io
      end

      def run
        io.puts dots
        io.puts failure_messages
        io.puts "\n#{examples.size} assertions, #{failed_examples.size} failures"
        passed?
      end

      def examples
        @results ||= begin
          session.visit(test.url)

          previous_results = ""

          session.wait_until(300) do
            dots = session.evaluate_script('Everblue.dots')
            io.print dots.sub(/^#{Regexp.escape(previous_results)}/, '')
            io.flush
            previous_results = dots
            session.evaluate_script('Everblue.done')
          end

          dots = session.evaluate_script('Everblue.dots')
          io.print dots.sub(/^#{Regexp.escape(previous_results)}/, '')

          JSON.parse(session.evaluate_script('Everblue.getResults()')).map do |row|
            Example.new(row)
          end
        end
      end

      def failed_examples
        examples.select { |example| not example.passed? }
      end

      def passed?
        examples.all? { |example| example.passed? }
      end

      def dots
        examples; ""
      end

      def failure_messages
        unless passed?
          examples.map { |example| example.failure_message }.compact.join("\n\n")
        end
      end
    end

    attr_reader :suite, :io

    def initialize(io=STDOUT)
      @io = io
    end

    def test_runner(test)
      TestRunner.new(self, test)
    end

    def run
      before = Time.now

      io.puts ""
      io.puts dots.to_s
      io.puts ""
      if failure_messages
        io.puts failure_messages
        io.puts ""
      end

      seconds = "%.2f" % (Time.now - before)
      io.puts "Finished in #{seconds} seconds"
      io.puts "#{examples.size} assertions, #{failed_examples.size} failures"
      passed?
    end

    def examples
      test_runners.map { |test_runner| test_runner.examples }.flatten
    end

    def failed_examples
      examples.select { |example| not example.passed? }
    end

    def passed?
      test_runners.all? { |test_runner| test_runner.passed? }
    end

    def dots
      test_runners.map { |test_runner| test_runner.dots }.join
    end

    def failure_messages
      unless passed?
        test_runners.map { |test_runner| test_runner.failure_messages }.compact.join("\n\n")
      end
    end

    def session
      @session ||= Capybara::Session.new(Everblue.driver, Everblue.application)
    end

    def suite
      @suite ||= Everblue::Suite.new
    end

  protected

    def test_runners
      @test_runners ||= suite.tests.map { |test| TestRunner.new(self, test) }
    end
  end
end

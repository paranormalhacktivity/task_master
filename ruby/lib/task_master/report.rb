module TaskMaster
  class Report
    def initialize(output_handler)
      @output_handler = output_handler
    end

    def generate(data)
      @output_handler.generate_output(data)
    end
  end
end

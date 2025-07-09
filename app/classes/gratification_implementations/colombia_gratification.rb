module GratificationImplementations
    class ColombiaGratification < GeneralGratification
        def initialize(daysCountedInYear:360)
            if daysCountedInYear > 365
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be greater that 365"
            end

            @daysCountedInYear = daysCountedInYear
        end

        def getDetails(input)
            if !input.key?(:monthly_salary) or !input.key?(:worked_days_semester)
                raise "Either The \"monthly salary\" or the \"worked days in the semester\" was not received correctly"
            end
            monthlySalary = (input[:monthly_salary]).to_f
            monthlySalaryStr =(monthlySalary.to_i).to_s
            workedDaysSemester = (input[:worked_days_semester]).to_i
            ammountGratification = self.getGratification(monthlySalary,workedDaysSemester)
            ammountGratificationStr = (ammountGratification.to_i).to_s
            return "Desglose: ($#{monthlySalaryStr}x#{workedDaysSemester})/#{@daysCountedInYear} = $#{ammountGratificationStr}"
        end

        def getGratification(monthlySalary,workedDaysSemester)
            return ((monthlySalary*workedDaysSemester)/@daysCountedInYear).to_i
        end    

        def getAmount(input)
            if !input.key?(:monthly_salary) or !input.key?(:worked_days_semester)
                raise "Either The \"monthly salary\" or the \"worked days in the semester\" was not received correctly"
            end
            monthlySalary = (input[:monthly_salary]).to_f
            workedDaysSemester = (input[:worked_days_semester]).to_i
            return self.getGratification(monthlySalary,workedDaysSemester)
        end    
    end
end
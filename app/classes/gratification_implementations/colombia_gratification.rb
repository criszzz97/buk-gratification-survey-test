module GratificationImplementations
    class ColombiaGratification < GeneralGratification
        def initialize(daysCountedInYear:360)
            if daysCountedInYear > 365
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be greater than 365"
            end

            if daysCountedInYear <= 0
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be equal or lower to 0"
            end

            @daysCountedInYear = daysCountedInYear
        end

        def getDetails(input)
            self.validateInput(input)
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
            self.validateInput(input)
            monthlySalary = (input[:monthly_salary]).to_f
            workedDaysSemester = (input[:worked_days_semester]).to_i
            return self.getGratification(monthlySalary,workedDaysSemester)
        end
        
        def validateInput(input)
            inputDto = ::InputModels::ColombiaGratificationInput.new(monthly_salary:input[:monthly_salary],worked_days_semester:input[:worked_days_semester])
            inputDto.validate!
        end  
    end
end

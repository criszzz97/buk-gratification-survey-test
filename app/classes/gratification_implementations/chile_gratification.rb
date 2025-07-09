module GratificationImplementations
    class ChileGratification < GeneralGratification
        def initialize(ratioOfAnnualRemuneration:0.25,consideredMonths:12,maximumMonthlyLegalRatio:4.75)
            @ratioOfAnnualRemuneration = ratioOfAnnualRemuneration
            @consideredMonths = consideredMonths
            @maximumMonthlyLegalRatio = maximumMonthlyLegalRatio
        end    
        def getDetails(input)
            monthlyBaseSalary = (input[:monthly_base_salary]).to_f
            minimumMonthlyIncome = (input[:minimum_monthly_income]).to_f
            percentageStr = (100*@ratioOfAnnualRemuneration).to_s
            annualSalaryGratificationOptionStr = (self.getBaseGratification(monthlyBaseSalary).ceil).to_s
            legalMaximumOptionStr = (self.getMinimumGratification(minimumMonthlyIncome).ceil).to_s
            return "Desglose: #{percentageStr.to_i}% del sueldo anual ($#{annualSalaryGratificationOptionStr}), tope legal ($#{legalMaximumOptionStr}). Se paga el menor."
        end

        def getAmount(input)
            monthlyBaseSalary = (input[:monthly_base_salary]).to_f
            minimumMonthlyIncome = (input[:minimum_monthly_income]).to_f
            baseGratification = self.getBaseGratification(monthlyBaseSalary)
            legalMaximumGratification = self.getMinimumGratification(minimumMonthlyIncome)
            gratificationArray = [baseGratification,legalMaximumGratification]
            return gratificationArray.min
        end

        def getBaseGratification(monthlyBaseSalary)
            return monthlyBaseSalary*@consideredMonths*@ratioOfAnnualRemuneration
        end

        def getMinimumGratification(minimumMonthlyIncome)
            return minimumMonthlyIncome*@maximumMonthlyLegalRatio
        end    
    end
end

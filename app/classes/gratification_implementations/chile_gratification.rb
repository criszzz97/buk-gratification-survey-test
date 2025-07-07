module GratificationImplementations
    class ChileGratification
        def initialize(ratioOfAnnualRemuneration=0.25,consideredMonths=12,maximumMonthlyLegalRatio=4.75)
            @ratioOfAnnualRemuneration = ratioOfAnnualRemuneration
            @consideredMonths = consideredMonths
            @maximumMonthlyLegalRatio = maximumMonthlyLegalRatio
        end    
        def getDetails(params)
            monthlyBaseSalary = params.require(:input)[:monthly_base_salary]
            minimumMonthlyIncome = params.require(:input)[:minimum_monthly_income]
            percentageStr = (100*@ratioOfAnnualRemuneration).to_s
            annualSalaryGratificationOptionStr = (self.getBaseGratification(monthlyBaseSalary).ceil).to_s
            legalMaximumOptionStr = (self.getMinimumGratification(minimumMonthlyIncome).ceil).to_s
            return "Desglose: #{percentageString}% del sueldo anual (#{annualSalaryGratificationOption}), tope legal (#{legalMaximumOptionStr}). Se paga el menor."
        end

        def getAmount(params)
            monthlyBaseSalary = params.require(:input)[:monthly_base_salary]
            minimumMonthlyIncome = params.require(:input)[:minimum_monthly_income]
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

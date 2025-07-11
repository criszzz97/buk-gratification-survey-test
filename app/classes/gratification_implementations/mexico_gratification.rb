module GratificationImplementations
    class MexicoGratification < GeneralGratification
        # Este constructor permite modificar en la instancia de la implementacion datos relativamente estaticos, tales como los dias que se consideran para
        # el calculo y la cantidad minima de dias contados para el calculo de aguinaldos.
        def initialize(daysCountedInYear:365,minimumDaysSalaryCountedInYear:15)
            if daysCountedInYear > 365
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be greater that 365"
            end

            if daysCountedInYear <= 0
                raise "The days (#{daysCountedInYear}) counted for the year gratification calculation cannot be equal or lower to 0"
            end

            if minimumDaysSalaryCountedInYear < 0
                raise "The minimum days counted for gratification calculation cannot be negative"
            end

            @daysCountedInYear = daysCountedInYear
            @minimumDaysSalaryCountedInYear = minimumDaysSalaryCountedInYear
        end

        # Esta funcion recibe como input los datos ingresados por el usuario (Salario diario y Dias trabajados en el año) y retorna un texto que contiene el desglose del caculo de gratificacion.
        def getDetails(input)
            self.validateInput(input)
            dailySalary = (input[:daily_salary]).to_f
            dailySalaryStr =(dailySalary.to_i).to_s
            workedDaysYear = (input[:worked_days_year]).to_f
            ammountGratification = self.getGratification(dailySalary,workedDaysYear)
            ammountGratificationStr = (ammountGratification.to_i).to_s
            workedDaysRatioStr = (workedDaysYear/@daysCountedInYear != 1) ? "x (#{workedDaysYear.to_i}/#{@daysCountedInYear}) " : ""
            return "Desglose: Salario diario ($#{dailySalaryStr}) x #{@minimumDaysSalaryCountedInYear} días #{workedDaysRatioStr}= $#{ammountGratificationStr}"
        end

        # Esta funcion recibe como input los datos ingresados por el usuario (Salario diario y Dias trabajados en el año) y retorna el monto de gratificacion cálculado a partir de los datos de entrada.
        def getAmount(input)
            self.validateInput(input)
            dailySalary = (input[:daily_salary]).to_f
            workedDaysYear = (input[:worked_days_year]).to_f
            return self.getGratification(dailySalary,workedDaysYear)
        end    

        # Esta funcion calcula la gratificacion a partir del salario diario y los dias trabajados en el año.
        def getGratification(dailySalary,workedDaysYear)
            return (dailySalary*@minimumDaysSalaryCountedInYear*(workedDaysYear/@daysCountedInYear)).to_i
        end 
        
        # Esta funcion valida los datos ingresados por el usuario (Salario diario y Dias trabajados en el año) con una clase DTO especifico asociado a esta implementacion.
        def validateInput(input)
            inputDto = ::InputModels::MexicoGratificationInput.new(daily_salary:input[:daily_salary],worked_days_year:input[:worked_days_year])
            inputDto.validate!
        end  
    end
end

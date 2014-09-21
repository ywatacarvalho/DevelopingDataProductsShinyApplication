
library(shiny)
library(UsingR)
data(galton)

shinyServer(
    function(input, output) {        
        
        nsimulations <- reactive({as.numeric(input$nsimulations)});
        beta0 <- reactive({as.numeric(input$beta0)});
        beta1 <- reactive({as.numeric(input$beta1)});
        stderror <- reactive({as.numeric(input$desv_pad_errors)});
        nsimulations <- reactive({as.numeric(input$nsimulations)});
        nobs <- reactive({as.numeric(input$nobs)});
        
        output$scatter_plot <- renderPlot ({
            input$goButton;
                        
            x <- rnorm(nobs(), 10, 10);
            errors <- rnorm(nobs(), 0, stderror());
            y <- beta0() + beta1() * x + errors;
                        
            par(mfrow = c(1,2));
            par(mar = c(4,4,4,2));
            
            plot(x, y, main = "Simulated Sample \n(One of the Samples)", col = 'blue', xlab="Predictive variable (x)", ylab = "Output variable (y)");
            reg1 <- lm(y ~ x);
            abline(reg1, col = 'red')
            
            hist(errors, main = "Histogram of Residues \n(One of the Samples)", col = 'red', xlab = "Residues");    
        })
        
        output$hist1 <- renderPlot ({
            input$goButton;
                        
            betas0_simul <- rep(0, nsimulations());
            betas1_simul <- rep(0, nsimulations());
            
            for (i in 1:nsimulations())
            {
                x <- rnorm(nobs(), 10, 10);
                errors <- rnorm(nobs(), 0, stderror());
                y <- beta0() + beta1() * x + errors;
                
                reg1 <- lm(y ~ x);
                coef <- reg1$coefficients;
                
                betas0_simul[i] <- as.numeric(coef[1]);
                betas1_simul[i] <- as.numeric(coef[2]);
            }
                
            par(mfrow = c(1,2));
            par(mar = c(4,4,4,2));
            
            hist(betas0_simul, main = "Histogram for Linear Coefficient \nEstimates", col = 'white', xlab = "Linear coef. estimates");     
            lines(c(beta0(),beta0()), c(0,200), col = "red", lwd = 5);
            
            hist(betas1_simul, main = "Histogram for Angular Coefficient \nEstimates", col = 'white', xlab = "Angular coef. estimates");    
            lines(c(beta1(),beta1()), c(0,200), col = "red", lwd = 5);        
            
            #                 beta0_mean <- mean(betas0_simul);
            #                 beta1_mean <- mean(betas1_simul);
        })
    }
)

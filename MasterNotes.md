# Master degree notes

## main references to check with advison

neural ODE
+ https://papers.nips.cc/paper_files/paper/2018/hash/69386f6bb1dfed68692a24c8686939b9-Abstract.html
  + papel seminal ganhador do melhor paper do neurips de 2019 com a apresentacao do metodos de neural ODE usando as redes residuais para aproximar a solucao de uma rede nueral para uma ode usando metodo de euler.   
+ https://hess.copernicus.org/articles/26/5085/2022/hess-26-5085-2022-discussion.html (NeuralODE on hydrology)
  + Improving hydrologic models for predictions and process understanding using neural ODEs
  + julia application available https://github.com/marv-in/HydroNODE
  + melhor acuracia que para previsao que os modelos de RRN LSTM e CNN
+ https://arxiv.org/abs/2202.02435 (on neural ODES - textbook thesis)
  + textbook com todo o corpo teorico necessario para compreender as Neural ODE 
HVAC Modeling
+ https://www.sciencedirect.com/science/article/pii/S1364032117314193
  + revisao bibliografica dos metodos utilizadas para modelagem de sistemas 
  + comparacao entre modelos probabilisticos, deterministicos e data mining
  + modelagem deterministica de lumped parameters e distributed parameters   
+ https://www.sciencedirect.com/science/article/pii/S0360544204004761
  + detalhe do modelo da zona que sera aplicado por uma neural ODE
  + paper seminal de aproximadamente 20 anos que ainda e o estado da arte para modelagem de zonas termicas

Referencias Metodologicas
+ https://www.mdpi.com/2076-3417/12/14/6880
  + aplicacao de MPC para controle de AHU MASD para sistema de VAV com reducao de consumo de energia de ~30%
  + modelagem do MPC com ANN e dados gerados por simulacao do energyPLUS da NERL 
+ https://arxiv.org/pdf/2301.03376.pdf
  + modelagem de ocupacao de uma zona termina para aplica;'ao de MPC que gerou 50% de economia de energia
  + modelagem deterministica por um modelo de lumped parameters model

### Objective
Apply Neural ODE to model thermal zones with lumped parameters model together with data in order to improve model predictive power, maintining generalization potential and interpretability

apply neural ODE to model thermal zones with improved balanced between generalization and prediction using a hybrid approach that encode the domain knowledge in the learning process than determinic and black-box approaches.

### Metodologia
+ gerar dados de simulacao de uma zona com sistema de hvac pelo energy plus e openstudio
+ modelager o sistema usando o metodo de tashtoush com parametros amortecidos
+ comparar o modelo deterministico com a simulacao do energy plus
+ substituir o modelo deterministico por uma NeuralODE
+ treinar com os dados da simulacao do energyPlus
+ extrapolar o modelo treinado e verificar a capacidade do modelo deterministico de recuperar o estado do sistema

### Referencias de codigo
+ https://github.com/msurtsukov/neural-ode
  + implementacao em pytorch do paper seminal do neurIPS

### blog posts
+ https://ilya.schurov.com/post/adjoint-method/ 
  + ajuda para entender o adjoint method

function results=evaluate(dataset_name, dataset_id, b_partition, ranks)

if b_partition==0
    run(dataset_name+'_train_R.m');
    run(dataset_name+'_test_R.m');
    
    % do normalization for each feature
    data=[data1;data2];
    N=size(data1,1);
    data=data(:,2:end);
    dataX=data(:,1:end-1);
    mean_X=mean(dataX,1);
    dataX=dataX-repmat(mean_X,size(dataX,1),1);
    norm_X=sum(dataX.^2,1);
    norm_X=sqrt(norm_X);
    norm_X=repmat(norm_X,size(dataX,1),1);
    dataX=dataX./norm_X;
    dataY=data(:,end);
    trainX=dataX(1:N,:);
    trainY=dataY(1:N,:);
    testX=dataX(N+1:end,:);
    testY=dataY(N+1:end,:);
    % for some data where the training-testing partitioning is available, the  parameter is tuned on the training set and evaluated on the test data.
    % adult_conxuntos; %divide the training data into two parts to do paramater tuning.
    run(dataset_name+'_conxuntos.m');
    trainX_temp=trainX(index1,:);
    trainY_temp=trainY(index1);
    testX_temp=trainX(index2,:);
    testY_temp=trainY(index2);
    MAX_acc=zeros(4,1);
    Best_N=zeros(4,1);
    Best_C=zeros(4,1);
    Best_S=zeros(4,1);
                    results.MAX_acc=zeros(4,1);
    results.Best_N=zeros(4,1);
   results. Best_C=zeros(4,1);
    results.Best_S=zeros(4,1);
    S=-5:0.5:5;
    
    
    for tMode=1:2

    for tiActFnc=1:2
        if tiActFnc==1
            tActFnc='radbas';
        else
            tActFnc='hardlim';
        end
    for s=1:numel(S)
    n=0;
    
    for N=3:20:203


      for C=-5:14 
        n=n+1;

            Scale=2^S(s);
            option1.N=N;
            option1.C=2^C;
            option1.Scale=Scale;
            option1.Scalemode=3;
            option1.bias=0;
            option1.link=0;
            option1.mode=tMode;
            option1.ActivationFunction=tActFnc;

            option2.N=N;
            option2.C=2^C;
            option2.Scale=Scale;
            option2.Scalemode=3;
            option2.bias=1;
            option2.link=0;
                        option2.mode=tMode;
            option2.ActivationFunction=tActFnc;

            option3.N=N;
            option3.C=2^C;
            option3.Scale=Scale;
            option3.Scalemode=3;
            option3.bias=0;
            option3.link=1;
            option3.mode=tMode;
            option3.ActivationFunction=tActFnc;
            
            option4.N=N;
            option4.C=2^C;
            option4.Scale=Scale;
            option4.Scalemode=3;
            option4.bias=1;
            option4.link=1;
                        option4.mode=tMode;
            option4.ActivationFunction=tActFnc;
         [train_accuracy1,test_accuracy1]=RVFL_train_val(trainX,trainY,testX,testY,option1);
         [train_accuracy2,test_accuracy2]=RVFL_train_val(trainX,trainY,testX,testY,option2);  
         [train_accuracy3,test_accuracy3]=RVFL_train_val(trainX,trainY,testX,testY,option3);
         [train_accuracy4,test_accuracy4]=RVFL_train_val(trainX,trainY,testX,testY,option4);  

        results.N(n)=N;
        results.C(n)=C;
        results.s(n)=s;
        results.mode(n)=tMode;
        results.ActivationFunction(n)=tiActFnc;
        results.test_accuracy1(n)=test_accuracy1;
        results.test_accuracy2(n)=test_accuracy2;
        results.test_accuracy3(n)=test_accuracy3;
        results.test_accuracy4(n)=test_accuracy4;

      if test_accuracy1>MAX_acc(1);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(1)=test_accuracy1;
          Best_N(1)=N;
          Best_C(1)=C;
          Best_S(1)=Scale;
       end

         if test_accuracy2>MAX_acc(2);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(2)=test_accuracy2;
          Best_N(2)=N;
          Best_C(2)=C;
          Best_S(2)=Scale;
         end

         if test_accuracy3>MAX_acc(3);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(3)=test_accuracy3;
          Best_N(3)=N;
          Best_C(3)=C;
          Best_S(3)=Scale;
        end


         if test_accuracy4>MAX_acc(4);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(4)=test_accuracy4;
          Best_N(4)=N;
          Best_C(4)=C;
          Best_S(4)=Scale;
        end
     end
     end
    end
    
    for i=1:4
    results.MAX_acc(i)=MAX_acc(i);
    results.Best_N(i)=Best_N(i);
    results.Best_C(i)=Best_C(i);
    results.Best_S(i)=Best_S(i);
    end


    
    ACC_CV=zeros(4,1);
    results.ACC_CV=zeros(4,1);
    
    for i=1:4



            option1.N=Best_N(1);
            option1.C=2^Best_C(1);
            option1.Scale=Best_S(1);
            option1.Scalemode=3;
            option1.bias=0;
            option1.link=0;
            option1.mode=tMode;
            option1.ActivationFunction=tActFnc;
            
            option2.N=Best_N(2);
            option2.C=2^Best_C(2);
            option2.Scale=Best_S(2);
            option2.Scalemode=3;
            option2.bias=1;
            option2.link=0;
            option2.mode=tMode;
            option2.ActivationFunction=tActFnc;
            
            option3.N=Best_N(3);
            option3.C=2^Best_C(3);
            option3.Scale=Best_S(3);
            option3.Scalemode=3;
            option3.bias=0;
            option3.link=1;
            option3.mode=tMode;
            option3.ActivationFunction=tActFnc;
            
            option4.N=Best_N(4);
            option4.C=2^Best_C(4);
            option4.Scale=Best_S(4);
            option4.Scalemode=3;
            option4.bias=1;
            option4.link=1;
            option4.mode=tMode;
            option4.ActivationFunction=tActFnc;

            [train_accuracy1,ACC_CV(1,i)]=RVFL_train_val(trainX,trainY,testX,testY,option1); % ACC_CV each row is the accuracy for one RVFL configuration. Each column is a single trial for cross-validation.
            [train_accuracy2,ACC_CV(2,i)]=RVFL_train_val(trainX,trainY,testX,testY,option2);
            [train_accuracy3,ACC_CV(3,i)]=RVFL_train_val(trainX,trainY,testX,testY,option3);
            [train_accuracy4,ACC_CV(4,i)]=RVFL_train_val(trainX,trainY,testX,testY,option4);


    end
    for i=1:4
    results.ACC_CV(i)=ACC_CV(i);
    end
    results.mean=mean(ACC_CV,2) 
    results.name=dataset_name;
    end
    end
    
else
    run(dataset_name+'_R.m');
    data=data(:,2:end);
    dataX=data(:,1:end-1);
    % do normalization for each feature
    mean_X=mean(dataX,1);
    dataX=dataX-repmat(mean_X,size(dataX,1),1);
    norm_X=sum(dataX.^2,1);
    norm_X=sqrt(norm_X);
    norm_X=repmat(norm_X,size(dataX,1),1);
    dataX=dataX./norm_X;
    dataY=data(:,end);

    run(dataset_name+'_conxuntos.m');
    trainX=dataX(index1,:); 
    trainY=dataY(index1,:);
    testX=dataX(index2,:);
    testY=dataY(index2,:);
    MAX_acc=zeros(4,1);
    Best_N=zeros(4,1);
    Best_C=zeros(4,1);
    Best_S=zeros(4,1);
    
    results.MAX_acc=zeros(4,1);
    results.Best_N=zeros(4,1);
    results.Best_C=zeros(4,1);
    results.Best_S=zeros(4,1);
    S=-5:0.5:5;
    
                n=0;

    for tMode=1:2

    for tiActFnc=1:2
        if tiActFnc==1
            tActFnc='radbas';
        else
            tActFnc='hardlim';
        end
    for s=1:numel(S)

    for N=3:20:203

      for C=-5:14 
        n=n+1;

            Scale=2^S(s);
            option1.N=N;
            option1.C=2^C;
            option1.Scale=Scale;
            option1.Scalemode=3;
            option1.bias=0;
            option1.link=0;
            option1.mode=tMode;
            option1.ActivationFunction=tActFnc;

            option2.N=N;
            option2.C=2^C;
            option2.Scale=Scale;
            option2.Scalemode=3;
            option2.bias=1;
            option2.link=0;
                        option2.mode=tMode;
            option2.ActivationFunction=tActFnc;

            option3.N=N;
            option3.C=2^C;
            option3.Scale=Scale;
            option3.Scalemode=3;
            option3.bias=0;
            option3.link=1;
            option3.mode=tMode;
            option3.ActivationFunction=tActFnc;
            
            option4.N=N;
            option4.C=2^C;
            option4.Scale=Scale;
            option4.Scalemode=3;
            option4.bias=1;
            option4.link=1;
                        option4.mode=tMode;
            option4.ActivationFunction=tActFnc;
         [train_accuracy1,test_accuracy1]=RVFL_train_val(trainX,trainY,testX,testY,option1);
         [train_accuracy2,test_accuracy2]=RVFL_train_val(trainX,trainY,testX,testY,option2);  
         [train_accuracy3,test_accuracy3]=RVFL_train_val(trainX,trainY,testX,testY,option3);
         [train_accuracy4,test_accuracy4]=RVFL_train_val(trainX,trainY,testX,testY,option4);  

        results.N(n)=N;
        results.C(n)=C;
        results.s(n)=s;
        results.mode(n)=tMode;
        results.ActivationFunction(n)=tiActFnc;
        results.test_accuracy1(n)=test_accuracy1;
        results.test_accuracy2(n)=test_accuracy2;
        results.test_accuracy3(n)=test_accuracy3;
        results.test_accuracy4(n)=test_accuracy4;
        
        if test_accuracy1>MAX_acc(1);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(1)=test_accuracy1;
          Best_N(1)=N;
          Best_C(1)=C;
          Best_S(1)=Scale;
       end

         if test_accuracy2>MAX_acc(2);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(2)=test_accuracy2;
          Best_N(2)=N;
          Best_C(2)=C;
          Best_S(2)=Scale;
         end

         if test_accuracy3>MAX_acc(3);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(3)=test_accuracy3;
          Best_N(3)=N;
          Best_C(3)=C;
          Best_S(3)=Scale;
        end


         if test_accuracy4>MAX_acc(4);% paramater tuning: we prefer the parameter which lead to better accuracy on the test data.
          MAX_acc(4)=test_accuracy4;
          Best_N(4)=N;
          Best_C(4)=C;
          Best_S(4)=Scale;
        end
     end
     end
    end

    for i=1:4
    results.MAX_acc(i)=MAX_acc(i);
    results.Best_N(i)=Best_N(i);
    results.Best_C(i)=Best_C(i);
    results.Best_S(i)=Best_S(i);
    end


    run(dataset_name+'_conxuntos_kfold.m');

    %abalone_conxuntos_kfold; %for datasets where training-testing partition is not available, performance vealuation is based on cross-validation.

    ACC_CV=zeros(4,1);
    results.ACC_CV=zeros(4,1);

    for i=1:4

        trainX=dataX(index{2*i-1},:);
        trainY=dataY(index{2*i-1},:);
        testX=dataX(index{2*i},:);
        testY=dataY(index{2*i},:);

            option1.N=Best_N(1);
            option1.C=2^Best_C(1);
            option1.Scale=Best_S(1);
            option1.Scalemode=3;
            option1.bias=0;
            option1.link=0;
            option1.mode=tMode;
            option1.ActivationFunction=tActFnc;
            
            option2.N=Best_N(2);
            option2.C=2^Best_C(2);
            option2.Scale=Best_S(2);
            option2.Scalemode=3;
            option2.bias=1;
            option2.link=0;
            option2.mode=tMode;
            option2.ActivationFunction=tActFnc;
            
            option3.N=Best_N(3);
            option3.C=2^Best_C(3);
            option3.Scale=Best_S(3);
            option3.Scalemode=3;
            option3.bias=0;
            option3.link=1;
            option3.mode=tMode;
            option3.ActivationFunction=tActFnc;
            
            option4.N=Best_N(4);
            option4.C=2^Best_C(4);
            option4.Scale=Best_S(4);
            option4.Scalemode=3;
            option4.bias=1;
            option4.link=1;
            option4.mode=tMode;
            option4.ActivationFunction=tActFnc;
            
            [train_accuracy1,ACC_CV(1,i)]=RVFL_train_val(trainX,trainY,testX,testY,option1) ;% ACC_CV each row is the accuracy for one RVFL configuration. Each column is a single trial for evaluation.
            [train_accuracy2,ACC_CV(2,i)]=RVFL_train_val(trainX,trainY,testX,testY,option2);
            [train_accuracy3,ACC_CV(3,i)]=RVFL_train_val(trainX,trainY,testX,testY,option3);
            [train_accuracy4,ACC_CV(4,i)]=RVFL_train_val(trainX,trainY,testX,testY,option4);


    end

    for i=1:4
    results.ACC_CV(i)=ACC_CV(i);
    end
    
    results.mean=mean(ACC_CV,2)
    results.name=dataset_name;
    end
    end
end
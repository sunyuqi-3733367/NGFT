function [uOut,damOut,WeOut]=time_stepping(uInput,damInput,WeInput,para)

% method-1 Miehe(2010): Only one iteration.It's ok, but not accurate.
% uOut=compute_disp(uInput,damInput,para);
% [damOut,WeOut]=compute_dam(uOut,WeInput,para);

% method-2:
uPre=uInput;
damPre=damInput;
Flag_1=1;
err=1e-6;
iter_1=1;

while Flag_1==1
      Flag_2=1;
      iter_2=1;
      while Flag_2==1
          fprintf('iter-%d-iter-%d: ',iter_1,iter_2);
          uNew=compute_disp(uPre,damPre,para);
          u_error=norm(uNew-uPre);
          fprintf('u_error: %d\n',u_error);
          if u_error<err
             Flag_2=0;
          end
          uPre=uNew;
          iter_2=iter_2+1;
      end
      [damNew,WeOut]=compute_dam(uNew,WeInput,para);
      dam_error=norm(damNew-damPre);
      if dam_error<err
         Flag_1=0;
      end
      fprintf('iter-%d-dam_error: %d\n',iter_1,dam_error);
      damPre=damNew;
      iter_1=iter_1+1;
end

uOut=uNew;
damOut=damPre;

end
function [tcount]=contaTuple(logfile,cwin)

%Stampa numero di tuple per ogni cwin
% [tcount]=contaTuple(logfile,cwin)

fid=fopen(logfile,'rt');
if (fid==-1)
    disp('Unable to open the file')
else
    i=1;
    while feof(fid)==0
             %Read one line into a string file
            linea=fgetl(fid);
            aline=split(linea);
            timestamps{i}=str2num(aline{1});
            i=i+1;
    end
    closeresult=fclose(fid);
    if closeresult~=0
         disp('Unable to close the file')
    end

    i=1;
    tcount=1;
    prev = timestamps{i};
    i = i + 1;
    [m,n]=size(timestamps);
    while i <= n
        succ = timestamps{i};
        %calcolo delta
        delta = succ - prev;
        if delta<cwin		
            j=0;	
        else
            tcount = tcount + 1;
        end
        prev = succ;
        i = i + 1;
    end
   
   %disp(tcount);
end


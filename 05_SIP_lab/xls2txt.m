clc; clear all;

% This routine reads the excel sheets and generates individual text files
% for all stations

[num,txt,raw] = xlsread('Mittelwerte_Met_Tzi.xlsx') ;

% % Loop over stations
% for ss = 1:25
%     fid = fopen([raw{1+(ss-1)*23,2} '.txt'],'wt'); % Open text file
%     % Loop over lines
%     for ii = (1:23)+(ss-1)*23
%         % Loop over columns
%         for jj = 1:8
%             % Print text and numbers
%             if ~isnan(raw{ii,jj})
%                 if ischar(raw{ii,jj})
%                     fprintf(fid,raw{ii,jj});
%                 else
%                     fprintf(fid,num2str(raw{ii,jj})); 
%                 end
%                 fprintf(fid,'\t'); % Separate columns by tab stops
%             end
% 
%         end
%         fprintf(fid,'\n'); % New line
%     end
%     fclose(fid); % Close text file
% end
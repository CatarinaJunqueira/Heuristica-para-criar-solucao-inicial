%***************************************************************/
%* Random value generator: Generates a value within bounds     */
%***************************************************************/
function val = randval(low, high)

   % To generate integer random numbers in the interval [l u]
   % we must use the following formula:
   % (1) rand()%k -> [0 1 2 3 ... k-1]      
   % (2) [l u]    -> rand()%(u-l) -> [0 1 ... (u-l-1)]
   % (3) [0 1 ... (u-l)] -> rand()%(u-l+1)
   % (4) rand()%(u-l+1) + l -> [l l+1 ... u]
   val = round(rand()*(high - low)) + low;

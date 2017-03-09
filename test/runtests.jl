using SLHA
using Base.Test

softsusy_spc = [SLHASpInfoBlock(Dict(1=>"SOFTSUSY",2=>"1.9.1")),
                SLHAModSelBlock(Dict(1=>"1")),
                SLHASMInputsBlock(Dict(1=>1.27934000e+02, 2=>1.16637000e-05,
                                       3=>1.17200000e-01, 4=>9.11876000e+01,
                                       5=>4.25000000e+00, 6=>1.74300000e+02,
                                       7=>1.77700000e+00)),
                SLHAMinParBlock(Dict(3=>1.00000000e+01, 4=>1.00000000e+00,
                                     1=>1.00000000e+02, 2=>2.50000000e+02,
                                     5=>-1.00000000e+02)),
				SLHAMassBlock(Dict( 24=>8.04191121e+01, 25=>1.10762378e+02,
                                    35=>4.00599584e+02, 36=>4.00231463e+02,
                                    37=>4.08513284e+02, 1000001=>5.72700955e+02,
                                    1000002=>5.67251814e+02,
                                    1000003=>5.72700955e+02,
                                    1000004=>5.67251814e+02,
                                    1000005=>5.15211952e+02,
                                    1000006=>3.95920984e+02,
                                    1000011=>2.04276615e+02,
                                    1000012=>1.88657729e+02,
                                    1000013=>2.04276615e+02,
                                    1000014=>1.88657729e+02,
                                    1000015=>1.36227147e+02,
                                    1000016=>1.87773326e+02,
                                    1000021=>6.07604198e+02,
                                    1000022=>9.72852615e+01,
                                    1000023=>1.80961862e+02,
                                    1000024=>1.80378828e+02,
                                    1000025=>-3.64435115e+02,
                                    1000035=>3.83135773e+02,
                                    1000037=>3.83371870e+02,
                                    2000001=>5.46070490e+02,
                                    2000002=>5.46999685e+02,
                                    2000003=>5.46070490e+02,
                                    2000004=>5.46999685e+02,
                                    2000005=>5.43966766e+02,
                                    2000006=>5.85698733e+02,
                                    2000011=>1.45526717e+02,
                                    2000013=>1.45526717e+02,
                                    2000015=>2.08222793e+02)),
                SLHAAlphaBlock(-1.13732831e-01),
                SLHAStopMixBlock(4.64231969e+02,
                                 [5.38083886e-01, 8.42891293e-01;
                                  8.42891293e-01, -5.38083886e-01]),
                SLHASbotMixBlock(4.64231969e+02,
                                 [9.47744273e-01, 3.19031021e-01;
                                  -3.19031021e-01, 9.47744273e-01]),
                SLHAStauMixBlock(4.64231969e+02,
                                 [2.80956141e-01, 9.59720609e-01;
                                  9.59720609e-01, -2.80956141e-01]),
                SLHANMixBlock(4.64231969e+02,
                              [9.86066377e-01, -5.46292061e-02,
                               1.47649927e-01, -5.37424305e-02;
                               1.02062420e-01, 9.42721210e-01,
                               -2.74985600e-01, 1.58880154e-01;
                               -6.04575099e-02, 8.97030908e-02,
                               6.95501068e-01, 7.10335491e-01;
                               -1.16624405e-01, 3.16616055e-01,
                               6.47194471e-01, -6.83587843e-01]),
                SLHAUMixBlock(4.64231969e+02,
                              [9.15531658e-01, -4.02245924e-01;
                               4.02245924e-01, 9.15531658e-01]),
                SLHAVMixBlock(4.64231969e+02,
                              [ 9.72345994e-01, -2.33545003e-01;
                                2.33545003e-01, 9.72345994e-01]),
                SLHAGaugeBlock(4.64231969e+02, Dict(1=>3.60968173e-01,
                                                    2=>6.46474399e-01,
                                                    3=>1.09626470e+00,)),
                SLHAYUBlock(4.64231969e+02, sparse([3], [3], [8.89731484e-01])),
                SLHAYDBlock(4.64231969e+02, sparse([3], [3], [1.39732269e-01])),
                SLHAYEBlock(4.64231969e+02, sparse([3], [3], [1.00914051e-01])),
                SLHAHMixBlock(4.64231969e+02, Dict(1=>3.58339654e+02,
                                                   2=>9.75145219e+00,
                                                   3=>2.44923803e+02,
                                                   4=>1.67100152e+05)),
                SLHAMSoftBlock(4.64231969e+02, Dict(1=>1.01439997e+02,
                                                    2=>1.91579315e+02,
                                                    3=>5.86586195e+02,
                                                    21=>3.23914077e+04,
                                                    22=>-1.29413007e+05,
                                                    31=>1.99042560e+02,
                                                    32=>1.99042560e+02,
                                                    33=>1.98204510e+02,
                                                    34=>1.38811933e+02,
                                                    35=>1.38811933e+02,
                                                    36=>1.36392545e+02,
                                                    41=>5.50815976e+02,
                                                    42=>5.50815976e+02,
                                                    43=>4.99361608e+02,
                                                    44=>5.28861326e+02,
                                                    45=>5.28861326e+02,
                                                    46=>4.18454191e+02,
                                                    47=>5.26100270e+02,
                                                    48=>5.26100270e+02,
                                                    49=>5.22780488e+02)),
                SLHAAUBlock(4.64231969e+02,
                            sparse([3], [3], [-5.04520155e+02])),
                SLHAADBlock(4.64231969e+02,
                            sparse([3], [3], [-7.97104366e+02])),
                SLHAAEBlock(4.64231969e+02,
                            sparse([3], [3], [-2.56146632e+02]))]

@test 1 == 2

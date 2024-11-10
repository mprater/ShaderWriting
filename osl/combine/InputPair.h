/*
 *  Copyright 2024 Mitch J Prater
 *
 *  Licensed under the Apache License Version 2.0 http://apache.org/licenses/LICENSE-2.0,
 *  or the MIT license http://opensource.org/licenses/MIT, at your option.
 *
 *  This program may not be copied, modified, or distributed except according to those terms.
 */
#define INPUT_PAIR(L) \
    float L##_in = 0.0 \
    [[ \
        string page = #L, \
        string label = "in", \
        string help = \
            "A float input. " \
    ]], \
\
    color L##_In = color(0.0) \
    [[ \
        string page = #L, \
        string label = "In", \
        string help = \
            "A tuple input: color, point, vector, or normal. " \
    ]]

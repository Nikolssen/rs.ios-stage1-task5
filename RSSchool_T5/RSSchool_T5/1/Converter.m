#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
- (NSString*) numberFormatter: (NSString*) string and: (NSNumber*) format; {
     NSMutableString *result = [NSMutableString new];
     [result appendString:@"+"];
    if ([format intValue] == 10) {
        ([result appendFormat:@"%c", [string characterAtIndex:0]]);
        int i = 1;
        while (i<string.length && i<11)
        {
            if (i == 1) [result appendString:@" ("];
            if (i == 4) [result appendString:@") "];
            if (i==7 || i == 9) [result appendString:@"-"];
            [result appendFormat:@"%c", [string characterAtIndex:i]];
            i++;
        }}
        else if ([format intValue] == 9) {
            ([result appendString:[string substringWithRange:NSMakeRange(0, 3)]]);
            int i = 3;
            while (i<string.length && i<12)
            {
                if (i == 3) [result appendString:@" ("];
                if (i == 5) [result appendString:@") "];
                if (i==8 || i == 10) [result appendString:@"-"];
                [result appendFormat:@"%c", [string characterAtIndex:i]];
                i++;
            }
        }
        else if ([format intValue] == 8) {
                ([result appendString:[string substringWithRange:NSMakeRange(0, 3)]]);
                int i = 3;
                while (i<string.length && i<11)
                {
                    if (i == 3) [result appendString:@" ("];
                    if (i == 5) [result appendString:@") "];
                    if (i==8) [result appendString:@"-"];
                    [result appendFormat:@"%c", [string characterAtIndex:i]];
                    i++;
                }
        }
        else {int i=0; int k=0;
            if ([string characterAtIndex:0] == '+'){ i=1; k=1;}
            while (i-k<12 && i<string.length){
            [result appendFormat:@"%c", [string characterAtIndex:i]];
            i++;}
            
        }
        
    
        return result;
}
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    NSDictionary *codeToData = @{
        @"375": @[@"BY", @9],
        @"7":   @[@"RU", @10],
        @"77":  @[@"KZ", @10],
        @"373": @[@"MD", @8],
        @"374": @[@"AM", @8],
        @"380": @[@"UA", @9],
        @"992": @[@"TJ", @9],
        @"993": @[@"TM", @8],
        @"994": @[@"AZ", @9],
        @"996": @[@"KG", @9],
        @"998": @[@"UZ", @9]
        };
    NSString *resultCountry = [NSString new];
    NSNumber *format = [[NSNumber alloc] initWithInt:0];
    
        NSMutableString *key = [NSMutableString new];
        [key appendFormat:@"%c", [string characterAtIndex:0]];
        if ([codeToData objectForKey:key])
        {
            if (string.length == 1)
                resultCountry = @"RU";
            else {
                if ([string characterAtIndex:1] == '7') {
                    resultCountry = @"KZ";
                    [key appendString:@"7"];}
                    else resultCountry = @"RU";
            }
              format =[codeToData[key] objectAtIndex:1];
        }
        else if (string.length!=2) [key appendString:[string substringWithRange:NSMakeRange(1, 2)]];
       if ([codeToData objectForKey:key])
       {
           resultCountry = [codeToData[key] objectAtIndex:0];
           format =[codeToData[key] objectAtIndex:1];
       }

    NSString *number = [NSString new];
    number = [self numberFormatter:string and:format];
    return @{KeyPhoneNumber: number,
             KeyCountry: resultCountry};
}
@end

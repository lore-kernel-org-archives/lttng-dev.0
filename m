From: David Bryant <david.bryant@quantum.com>
Subject: Re: Test if tracepoint is enabled
Date: Thu, 6 Dec 2012 11:49:16 +1030
Message-ID: <50BFF294.50508__6682.38890725679$1354756817$gmane$org@quantum.com>
References: <50B43D06.7020709@quantum.com> <20121203143421.GA4458@Krystal>
	<50BD3499.3000509@quantum.com> <20121204140244.GA5298@Krystal>
	<50BE8FF9.5010807@quantum.com> <20121205101919.GA29447@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=868715a0b4=david.bryant@quantum.com>)
	id 1TgQ7i-0001T0-Lo
	for lttng-dev@lists.lttng.org; Wed, 05 Dec 2012 20:19:34 -0500
In-Reply-To: <20121205101919.GA29447@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 05/12/12 20:49, Mathieu Desnoyers wrote:
> * David Bryant (david.bryant@quantum.com) wrote:
>> So, building on your example:
>>
>> #define tracepoint_cond(provider, name, pre, post, ...) \
>>      do { \
>>          if (caa_unlikely(__tracepoint_##provider##___##name.state)) { \
>>              pre \
>>              __tracepoint_cb_##provider##___##name(__VA_ARGS__); \
>>              post \
>>          } \
>>      } \
>>      while (0)
>>
>> And a contrived example:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> int main() {
>>      char * a;
>>      tracepoint_cond(provider, name,
>>                      { printf("pre\n");  a = malloc(16); },
>>                      { printf("post\n"); free(a);        }
>>                     );
>>      return 0;
>> }
>>
>> This is ok. But more work with the macro handling would be required to
>> get the pre/post code fragments through as parameters. The example only
>> compiles because its pre/post arguments don't contain any commas.
>>
>> What do you think?
> I'm not sure what parameters would cause issues with commas. If they are
> between parenthesis or brackets, it should be fine. Do you have an
> example perhaps ?
Ok, I've just learnt what 'statement-expressions' are 
(http://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html). Would this be 
the first use of these in lttng-ust? If so, I'm wary of making lttng-ust 
dependent on this gcc extension. Would it be dependent on this? It is up 
to the user to decide what to pass to the macro, but the macro may 
impose constraints by way of how the arguments are employed within the 
macro...

As it happens, we compile with -pedantic which won't allow 
statement-expressions. (As an aside, -pedantic doesn't like tracepoint 
that don't take any arguments because it expects the "..." to have at 
least one argument).

My example above (that doesn't use statement-expressions - I removed the 
round brackets) compiles correctly. But it you introduce a comma then 
the compiler seems to interpret this as an argument separator. So this 
works:

   #include <stdio.h>
   #include <stdlib.h>

   #define tracepoint_cond(provider, name, cond, pre, post, ...) \
       do { \
           if (caa_unlikely(__tracepoint_##provider##___##name.state)) { \
               if (cond) { \
                   pre \
__tracepoint_cb_##provider##___##name(__VA_ARGS__); \
                   post \
               } \
           } \
       } \
       while (0)

   int main() {
       int i = 1, j = 1;

       char * a;
       tracepoint_cond(provider, name,
                       i == j,  /* condition */
                       {   /* pre */
                       a = malloc(16);
                       memset(a, 0, 16);
                       },
                       {   /* post */
                       free(a);
                       int dummy1;
                       },
                       a
                      );
       return 0;
   }

But changing tracepoint_cond to this breaks it:

       tracepoint_cond(provider, name,
                       i == j,  /* condition */
                       {   /* pre */
                       a = malloc(16);
                       memset(a, 0, 16);
                       },
                       {   /* post */
                       free(a);
                       int dummy1, dummy2;  /* XXX */
                       },
                       a
                      );

Examining the pre-processed code reveals that the comma causes dummy2 to 
become a subsequent argument to the macro and land in the "..." region, 
and hell breaks loose.

Do you think we could come up with a scheme that doesn't impose the use 
of statement-expressions, but supports them if they are provided? In my 
example, I simply provide 'i == j' as the condition, but a 
statement-expression would also work. Are we conflating separate ideas - 
the idea of user conditions and the idea of setup/cleanup?

> While we are there, it would be good to make the "pre" handler test a
> condition. For your use-case, you would just have to pass a pre :
>
>   { printf("pre\n");  a = malloc(16); 1; }
>
> So we could do:
>
>     if (pre)
>          __tracepoint_cb_##provider##___##name(__VA_ARGS__);
>     (post)
>
> and therefore support not only to setup something, but also to add an
> extra check on whether tracing should be skipped or not. If someone
> passes "1" as end of the compound statement, it will always evaluate to
> 1, and therefore the compiler will remove any extra branch in -O2.
>
> One question stands though: how would we integrate this with sdt.h
> STAP_PROVEV() ?
I'm yet to look at this.

Thanks,
Dave

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.

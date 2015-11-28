From: Zvi Vered <veredz72@gmail.com>
Subject: Re: compile error in lttng-ust-2.4.4
Date: Sun, 29 Nov 2015 00:13:47 +0200
Message-ID: <CABRndgxF7eqMAhhL268CEgoNvDSDGVtKFNixyc5ahQBjYDsqaQ__18932.0786078044$1448748886$gmane$org@mail.gmail.com>
References: <CABRndgwATfY9cPKb2JSzg_aO=8Q6_qZxRsf-YxnahhoMU6QH1A@mail.gmail.com>
 <CAF4oYfGjHjFY0MVRRht6KbxbDW74Grjo=hw1V_SVWtNydFPjTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f181.google.com ([209.85.223.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <veredz72@gmail.com>) id 1a2nkh-0002pt-2T
 for lttng-dev@lists.lttng.org; Sat, 28 Nov 2015 17:13:57 -0500
Received: by iofh3 with SMTP id h3so142056218iof.3
 for <lttng-dev@lists.lttng.org>; Sat, 28 Nov 2015 14:13:47 -0800 (PST)
In-Reply-To: <CAF4oYfGjHjFY0MVRRht6KbxbDW74Grjo=hw1V_SVWtNydFPjTg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jonathan,

I tried compiling lttng-ust-2.7.1 and got the same compilation error.
gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)

I think (not sure) that compiling with newer gcc will not have this error.

Regards,
Z.V

On 11/27/15, Jonathan Rajotte <jonathan.r.julien@gmail.com> wrote:
> Hi Zvi,
>
> The 2.4 tool set (modules/ust/tools) is not officially supported (actively
> developed) anymore. I highly encourage you to move towards lttng 2.7 tool
> set unless you have very specific requirements.
>
> Cheers!
>
>
> On Thu, Nov 26, 2015 at 11:20 PM, Zvi Vered <veredz72@gmail.com> wrote:
>
>> Hello,
>>
>> I downloaded lttng-ust-2.4.4 extracted it and ran ./configure
>> Then I ran make.
>>
>> I got the following error:
>>
>> ....
>>   CC       lttng-filter-specialize.lo
>>   CC       lttng-filter-interpreter.lo
>>   CC       lttng-ust-baddr.lo
>> In file included from ../include/lttng/ust-tracepoint-event.h:724,
>>                  from ../include/lttng/tracepoint-event.h:58,
>>                  from ust_baddr_statedump.h:56,
>>                  from lttng-ust-baddr.c:40:
>> ././ust_baddr_statedump.h:40: error: weak declaration of
>> '__ref_loglevel___ust_baddr_statedump___soinfo' must be public
>> ././ust_baddr_statedump.h:40: error:
>> '__ref_loglevel___ust_baddr_statedump___soinfo' defined both normally
>> and as an alias
>> ././ust_baddr_statedump.h:40: error: weak declaration of
>> '__ref_model_emf_uri___ust_baddr_statedump___soinfo' must be public
>> ././ust_baddr_statedump.h:40: error:
>> '__ref_model_emf_uri___ust_baddr_statedump___soinfo' defined both
>> normally and as an alias
>> make[2]: *** [lttng-ust-baddr.lo] Error 1
>> make[2]: Leaving directory
>> `/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4/liblttng-ust'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4'
>> make: *** [all] Error 2
>>
>> I'm running under Centos 5.5 (32),
>> gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>>
>> Best regards,
>> Z.V
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
>
> --
> Jonathan Rajotte Julien
>

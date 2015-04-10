From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Fri, 10 Apr 2015 19:57:21 -0400
Message-ID: <CAB4xu_2F1QF=_iO-_jHj_YszLNq=ia1sPrchHP9aBBbmot5ADw__12651.4558135115$1428710327$gmane$org@mail.gmail.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
 <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
 <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA@mail.gmail.com>
 <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Ygio9-0006xh-CW
 for lttng-dev@lists.lttng.org; Fri, 10 Apr 2015 19:58:01 -0400
Received: by lbbuc2 with SMTP id uc2so24345159lbb.2
 for <lttng-dev@lists.lttng.org>; Fri, 10 Apr 2015 16:57:51 -0700 (PDT)
In-Reply-To: <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anand Neeli <anand.neeli@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Mar 23, 2015 at 9:36 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Perhaps your program is clearing its environment
> variables ? Or launched by a wrapper that clears
> the env. var. ?

Perhaps LTTng-UST should do like LTTng-tools: try $LTTNG_HOME, then
$HOME, then the current UID's entry in /etc/passwd? This would avoid
disabling per-user tracing even when the environment variables are cleared.

WDYT?

Phil

>
> Can you try with a simple demo program to find our
> what is clearing those ?
>
> Thanks,
>
> Mathieu
>
>
> ________________________________
>
> Hi All,
> I'm sorry to bump on this thread again.
>
> Is there any way to overcome this issue?
>
> Thanks,
> Anand Neeli
>
> On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R <chid1989@gmail.com> wrote:
>>
>> I too am getting the same errors. Inspite of setting LTTNG_HOME in my
>> program.
>>
>> On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <anand.neeli@gmail.com>
>> wrote:
>>>
>>> Hi All,
>>>
>>> any idea when do we get this error?
>>>
>>> app: libust[4745/4745]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4751/4751]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4760/4760]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4780/4780]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>>
>>> i have set LTTNG_HOME=HOME=/home/root
>>> using 2.6
>>>
>>> Thanks,
>>> Anand Neeli
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

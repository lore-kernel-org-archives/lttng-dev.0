From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH lttng-ust] Add ctor/dtor priorities for
 tracepoints/events
Date: Sun, 12 Jul 2020 11:49:26 -0400
Message-ID: <87tuycybqx.fsf@clara>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
 <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
Reply-To: Olivier Dion <olivier.dion@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B4WQZ345Gz1VPk
 for <lttng-dev@lists.lttng.org>; Sun, 12 Jul 2020 11:48:22 -0400 (EDT)
In-Reply-To: <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sun, 12 Jul 2020, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- On Jul 11, 2020, at 11:29 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>
>> Some library might want to generate events in their ctor/dtor.  If
>> LTTng initialize/finalize its tracepoints/events at the wrong time,
>> events are lost.
>> 
>> Order of execution of the ctor/dtor is determined by priority.  When
>> some priorities are equal, the order of execution seems to be
>> determined by:
>> 
>>	   a) Order of appearance if in the same compilation unit
>> 
>>	   b) Order of link if in different compilation units
>> 
>>	   c) Order of load by ld-linux.so or dlopen(3) for
>>	      share objects
>
> I recall different rules about constructor priorities. Can you provide
> links to documentation stating the priority order you describe above ?

I haven't found any documentation on that.  This is purely empirical.
Although I'm sure that we can dig something if chatting on GCC's IRC.

> Also, we should compare two approaches to fulfill your goal:
> one alternative would be to have application/library constructors
> explicitly call tracepoint constructors if they wish to use them.

I would prefer this way.  The former solution might not work in some
cases (e.g. with LD_PRELOAD and priority =101) and I prefer explicit
initialization in that case.

I don't see any cons for the second approach, except making the symbols
table a few bytes larger.  I'll post a patch soon so we can compare and
try to find more documentation on ctor priority.

-- 
Olivier Dion
PolyMtl

From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: What is _prev_state in sched_switch?
Date: Wed, 24 Jul 2019 10:02:54 -0400
Message-ID: <0e850b02-3fec-a335-3f37-8579ad1b704d__22150.1503068552$1563977507$gmane$org@gydle.com>
References: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45ty2C6NfWz1G84
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 10:11:31 -0400 (EDT)
In-Reply-To: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ravindra Kumar Meena <rmeena840@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



On 2019-07-24 2:44 a.m., Ravindra Kumar Meena wrote:
> Hi,
> 
> I had a looked at TraceCompass example. I came across sched_swithc event in present in the metadata.
> 
> event {
> name = "sched_switch";
> id = 27;
> stream_id = 0;
> fields := struct {
> integer { size = 8; align = 8; signed = 0; encoding = UTF8; base = 10; } _prev_comm[16];
> integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; } _prev_tid;
> integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; } _prev_prio;
> integer { size = 64; align = 8; signed = 1; encoding = none; base = 10; } _prev_state;
> integer { size = 8; align = 8; signed = 0; encoding = UTF8; base = 10; } _next_comm[16];
> integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; } _next_tid;
> integer { size = 32; align = 8; signed = 1; encoding = none; base = 10; } _next_prio;
> };
> };
> 
> All event.fields variables are clear to me but what does _prev_state do here? I had a looked at its babeltrace output but found no pattern in _prev_state value.
> 
> Please attend this email ASAP.

I think that writing "Please attend this email ASAP" is somehow rude.

> 
> Thanks
> 
> -- 
> *Ravindra Kumar Meena*,
> B. Tech. Computer Science and Engineering,
> Indian Institute of Technology (Indian School of Mines) <https://www.iitism.ac.in/>, Dhanbad
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

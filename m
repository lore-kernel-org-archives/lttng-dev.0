From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [lttng-dev] Using lttng-ust's libringbuffer outside lttng-ust
Date: Fri, 15 Feb 2013 15:36:11 -0500
Message-ID: <CAGDH53=8kL0oXWZ0Xo73-1EviVbheU0t9fXuzSt05ZCSqVzH_w@mail.gmail.com>
References: <511A9E5A.4010303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <systemtap-return-20417-gls-systemtap=m.gmane.org@sourceware.org>
In-Reply-To: <511A9E5A.4010303@redhat.com>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
To: David Smith <dsmith@redhat.com>
Cc: lttng-dev@lists.lttng.org, systemtap@sourceware.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

> Over in systemtap land, we're working on implementing a pure userspace
> backend, using a project called dyninst (<http://www.dyninst.org/>).

This project looks very interesting!

> Assuming it does make sense, I could use some help. Is there any
> documentation that I've missed somewhere that describes libringbuffer in
> any detail?

I found some old presentation that Mathieu did a Linuxcon in 2010 [1].
The presentation describe the unified kernel ringbuffer on which the
user space one is based. I'm afraid that if you want up-to-date
documentation, the source code will be the best place to look.

> The next question would be what is the best way of using libringbuffer
> outside lttng-ust. One (not great) possibility would be to just copy the
> code into systemtap. Of course the problem there is keeping the code up
> to date with changes in lttng-ust. The next possibility would be to make
> it a separate project (more like userspace-rcu).

Splitting libringbuffer from the UST tree right now would prove to be
quite a challenge. We would need to expose an API to the "clients" of
the ringbuffer. Currently there are two levels of abstraction that one
can use with the ringbuffer: a "high-level" one where you use a
predefined "client" with the associated performance degradation and a
"low-level" one where you know exactly which kind of "client" you are
using with the associated fast-path inlined.

We would need to discuss which level of abstraction we expose to the
user: a generic one or "N apis" for the different low-level "clients".

With that said, I'm curious about which specific features of Dyninst
SystemTAP will be using and also do you think that it would be
possible to integrate Dyninst as an additional instrumentation source
into lttng-ust?

Thanks,

Christian

[1] -  A new unified Lockless Ring Buffer library for efficient kernel tracing:
        http://www.efficios.com/pub/linuxcon2010-tracingsummit/presentation-linuxcon-2010-tracing-mini-summit.pdf

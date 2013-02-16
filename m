From: Josh Stone <jistone@redhat.com>
Subject: Re: [lttng-dev] Using lttng-ust's libringbuffer outside lttng-ust
Date: Fri, 15 Feb 2013 19:43:55 -0800
Message-ID: <511F007B.9020701@redhat.com>
References: <511A9E5A.4010303@redhat.com> <CAGDH53=8kL0oXWZ0Xo73-1EviVbheU0t9fXuzSt05ZCSqVzH_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-20418-gls-systemtap=m.gmane.org@sourceware.org>
In-Reply-To: <CAGDH53=8kL0oXWZ0Xo73-1EviVbheU0t9fXuzSt05ZCSqVzH_w@mail.gmail.com>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: David Smith <dsmith@redhat.com>, lttng-dev@lists.lttng.org, systemtap@sourceware.org
List-Id: lttng-dev@lists.lttng.org

On 02/15/2013 12:36 PM, Christian Babeux wrote:
> With that said, I'm curious about which specific features of Dyninst
> SystemTAP will be using and also do you think that it would be
> possible to integrate Dyninst as an additional instrumentation source
> into lttng-ust?

We're using Dyninst mainly like a pure-userspace form of uprobes, so we
can instrument a process without any direct kernel involvement.  In this
mode, stap is perfectly fine for unprivileged users (on their own
processes), and it can be faster too since it's running instrumentation
directly in-process (versus uprobes' breakpoint trap).  Like uprobes,
these instrumentation points can be anywhere in the process.

And sure, I can definitely see lttng using it for similar reasons.
We've already packaged Dyninst in Fedora, if you'd like to try it out.

Josh

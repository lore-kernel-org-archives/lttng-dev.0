From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Reusing tracepoint definition with same type of
 arguments but in different order
Date: Wed, 2 Jul 2014 14:26:22 +0000 (UTC)
Message-ID: <1033348953.7107.1404311182259.JavaMail.zimbra__13222.5925488912$1404311296$gmane$org@efficios.com>
References: <CAEEAEzV00Hv1+zA3DgQaU5v+-3myAypoxAds3iAE_dWEZ852xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X2LUO-0005qF-IS
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 10:26:30 -0400
In-Reply-To: <CAEEAEzV00Hv1+zA3DgQaU5v+-3myAypoxAds3iAE_dWEZ852xg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Sandeep K Chaudhary" <babbusandy2006@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, July 2, 2014 2:09:48 AM
> Subject: [lttng-dev] Reusing tracepoint definition with same type of arguments but in different order
> 
> Hi guys,
> 
> Is it possible to reuse a tracepoint definition for a different trace
> with same type (and number) of arguments but in different order?
> 
> Specifically, if I have the arguments in the following order in the
> definition
> 
>         TP_ARGS(
>                 int, anint,
>                 long *, values,
>                 char *, text,
>                 double, doublearg,
>                 float, floatarg,
>                 bool, boolarg
>          )
> 
> Using some technique, would this definition be directly usable for a
> tracepoint with the argument order -  "long *, int, char *, double,
> float, bool" or some other order for the matter?

No.

> 
> I understand that I can always change the order appropriately
> according to the definition in the trace-point insertion but I am
> interested in knowing if there is a way to even avoid this. Please let
> me know.

Thanks,

Mathieu

> 
> Thanks and regards,
> Sandeep.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

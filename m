From: "Ostermueller, Erik" <Erik.Ostermueller@fisglobal.com>
Subject: Re: Java code for CTF trace writing?
Date: Mon, 6 May 2013 14:33:57 +0000
Message-ID: <A94B468263DDE2448A14367F590EB97301D4DA41__36786.1211220317$1367850919$gmane$org@ltcfiswmsgmb15>
References: <CAB4xu_1zOHUD03dQ57DxKpQ1RWorocGK_0URCaxnohHB1FLEDw@mail.gmail.com>
	<5176AAFA.8060905@ericsson.com>
	<1962635283.7490228.1366741297558.JavaMail.root@vmware.com>
	<5176D556.8040801@ericsson.com>
	<1218416875.7614701.1366750233878.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.fisglobal.com ([199.200.24.190])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Erik.Ostermueller@fisglobal.com>) id 1UZMUl-0006aS-Et
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 10:34:27 -0400
In-Reply-To: <1218416875.7614701.1366750233878.JavaMail.root@vmware.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aaron Spear <aspear@vmware.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: Philippe Proulx <philippe.proulx@polymtl.ca>, Dominique Toupin <dominique.toupin@ericsson.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Linux Tools developer discussions <linuxtools-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Hello all,

I've got a question about the Java code that writes CTF traces.
Would this design provide a single trace with Java events and OS events in the same trace?
Here is an example:

Consider an all-Java program that sends an XML requests request over HTTP.
Would like the trace detail to show Java method activity as well as OS activity that opens/closes the socket.

This could be very helpful for unveiling the details of how Java code consumes hardware resources.

Thanks,
--Erik

-----Original Message-----
From: Aaron Spear [mailto:aspear@vmware.com] 
Sent: Tuesday, April 23, 2013 3:51 PM
To: Matthew Khouzam
Cc: Philippe Proulx; Dominique Toupin; lttng-dev@lists.lttng.org; Linux Tools developer discussions
Subject: Re: [lttng-dev] Java code for CTF trace writing?

> When would you be available to work on this feature, I would love to 
> sync up our efforts for this.

The way things look right now, I will have bandwidth for it in another month, so middle to end of May. Perhaps sooner if all the stars align.

Aaron

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

_____________
The information contained in this message is proprietary and/or confidential. If you are not the intended recipient, please: (i) delete the message and all copies; (ii) do not disclose, distribute or use the message in any manner; and (iii) notify the sender immediately. In addition, please be aware that any message addressed to our domain is subject to archiving and review by persons other than the intended recipient. Thank you.

From: David OShea <David.OShea@quantum.com>
Subject: Re: How to disable an event that's been enabled by a
 wildcard selection or -a?
Date: Thu, 14 Feb 2013 04:52:28 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F968AF__18811.8292637684$1360817606$gmane$org@ZURMSG1.QUANTUM.com>
References: <009B25148989C6458484484699278506985C0CFA@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=075774e2d3=david.oshea@quantum.com>)
	id 1U5qoD-0002tU-PC
	for lttng-dev@lists.lttng.org; Wed, 13 Feb 2013 23:52:33 -0500
In-Reply-To: <009B25148989C6458484484699278506985C0CFA@EU-MBX-01.mgc.mentorg.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

My understanding (hopefully someone will correct me if I'm wrong) is that each time you invoke 'lttng enable-event', your specification for the events you want enabled is stored and applied, and/or potentially applied later if a new application connects to the session daemon.  All 'lttng disable-event' does is remove one of the specifications you previously provided to 'lttng enable-event', so you can't say 'enable-event *' and then 'disable-event foo:*' to get all events except 'foo:*'.

If you could constrain the application to use a particular trace provider name for all of its tracepoints, say "app", then you could just do 'lttng enable-event app:*'.  If you can't do that, then I think you need to fall back on getting a list of all the available tracepoints using 'lttng list -u', parsing this to find all of the available tracepoints, extracting the trace provider name from them, then using 'lttng enable-event <provider>:*' for each provider other than the provider from your uninteresting library.  I think there are APIs that can be used instead of issuing the 'lttng' commands.

I would certainly also like a way to be able to, say, enable all events other than foo:* and bar:* using one command.

Regards,
David

> -----Original Message-----
> From: Ikaheimonen, JP [mailto:jp_ikaheimonen@mentor.com]
> Sent: Friday, 8 February 2013 7:56 PM
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] How to disable an event that's been enabled by a
> wildcard selection or -a?
> 
> Consider the following scenario.
> I want to write a script that traces all UST tracepoints of a given
> application. I have no idea what the names of these tracepoints are.
> Also, I know that the application uses a library that contains some
> tracepoints I am not interested about. Now I want to trace all UST
> tracepoints except the ones I already know about. Is this possible with
> the lttng commands?
> 
> If I enable all tracepoints with "lttng enable-event -u -a" I get all
> events, even those I do not want. I've tried using "lttng disable-
> event", and "lttng enable-event" with a filter, but I cannot seem to be
> able to get rid of the specific events.
> 
> Thank you,
> 
> JP Ikaheimonen
> Mentor Graphics Embedded Systems Division
> Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
> 
> Android is a trademark of Google Inc. Use of this trademark is subject
> to Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and
> other countries.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.

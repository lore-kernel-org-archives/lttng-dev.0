From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: How to disable an event that's been enabled by a
 wildcard selection or -a?
Date: Fri, 3 May 2013 12:40:53 +0200
Message-ID: <51839435.8010607__44394.1635931425$1367577703$gmane$org@mentor.com>
References: <009B25148989C6458484484699278506985C0CFA@EU-MBX-01.mgc.mentorg.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB19F968AF@ZURMSG1.QUANTUM.com>
	<5121EA9A.8080905@mentor.com> <20130502134010.GF7035@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1UYDQH-0004sp-01
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 06:41:05 -0400
In-Reply-To: <20130502134010.GF7035@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 05/02/2013 03:40 PM, Mathieu Desnoyers wrote:
> Hi Paul,
> =

> I would be interested to see this feature upstream. Previously was not a
> good timing to pull it in, because we were adding the concept of event
> "enablers" within lttng-ust.

Sounds great. I will port our patch to master.

> =

> One thing I'm curious about is how you present the logical combination
> with exlusion match are present. For instance, if we only have
> inclusion, we get:
> =

> lttng enable-event 'a'
> lttng enable-event 'c'
> lttng enable-event 'zc*'
> =

> it turns into :   (a || c || zc*)
> =

> I expect that negation would look like:
> =

> lttng enable-event 'a'
> lttng enable-event '!abc*'
> lttng enable-event 'c'
> lttng enable-event '!cxx'

Our current solution does not handle '!cxx' correctly.
I will fix that.

> lttng enable-event 'zc*'
> =

> ->  !(abc* || cxx) || (a || c || zc*)

Exactly. The "!something" wildcards are always first and will prevent furth=
er matching with non-! wildcards.

> =

> Am I correct ? If yes, we should expand lttng-tools lttng(1) manpage and
> cmd help with this info.

I will take care of documentation updates as well.

> =

> Can you make sure it works well with lttng-ust master branch ?

Once I have a working, tested patch against master I will send it to you.

Thanks,
Paul

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.

From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: CTF writer in Java
Date: Mon, 6 May 2019 09:26:39 -0400
Message-ID: <20190506132639.GA12560__17981.1086550885$1557149420$gmane$org@joraj-alpa>
References: <34675397.591240.1557142800147.JavaMail.zimbra@univ-pau.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44yNnG6SRmz1L6h
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 09:26:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 046C81DF824
 for <lttng-dev@lists.lttng.org>; Mon,  6 May 2019 09:26:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <34675397.591240.1557142800147.JavaMail.zimbra@univ-pau.fr>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Lea Brunschwig <lea.brunschwig@univ-pau.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Lea,

On Mon, May 06, 2019 at 01:40:00PM +0200, Lea Brunschwig wrote:
> Hello, =

> =

> I am working on a Java API that permits to create UML state machine and t=
o run
> them. I have created a Java interface allowing to implement customizable =
trace
> for this tool: the user can implement its own way to gather information f=
rom
> the execution for instance print in the console via System.out.println() =
or
> print in a xml file, etc... =

> =

> In the scope of the project I am working on I would like to provide the u=
sers
> a Java class implemeting my interface with the CTF format but I can not m=
anage
> to find a code able to write a CTF trace in Java. Does such a code exist? =


lttng-ust provides JUL and log4j java agents that leverage the current lttn=
g stack.

https://lttng.org/docs/v2.10/#doc-java-application

We do not provide a Java CTF writer as is AFAIK.

Cheers.

> =

> Since CTF traces seem to be really specific I do not want to intent to wr=
ite
> my own version of a CTF trace because I am scared it would not be accurat=
e and
> would not work with the already existing CTF readers. =

> =

> Thank you in advance. =

> L=E9a Brunschwig =


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Jonathan Rajotte-Julien
EfficiOS

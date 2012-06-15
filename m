From: Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
Subject: Re: lttng - ubuntu 11.10 - problem
Date: Fri, 15 Jun 2012 11:32:02 -0400
Message-ID: <4FDB5572.7000209__14220.4498559751$1339774359$gmane$org@polymtl.ca>
References: <1339746088.90723.YahooMailNeo@web161201.mail.bf1.yahoo.com>
	<4FDAEF5C.9030102@gmail.com> <4FDB34C8.7000505@polymtl.ca>
	<20120615151234.GA28295@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexandre.montplaisir@polymtl.ca>)
	id 1SfYVM-0001io-Hj
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 11:32:08 -0400
In-Reply-To: <20120615151234.GA28295@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, bapi_mvit2004@yahoo.com
List-Id: lttng-dev@lists.lttng.org

On 12-06-15 11:12 AM, Mathieu Desnoyers wrote:
> * David Goulet (david.goulet@polymtl.ca) wrote:
> Hi,
>
> In order to trace the kernel, you need the LTTng kernel modules
> available in
> the package "lttng-modules-dkms". So make sure you have these three
> packages
> installed:
>
> # sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
>
> > hopefully lttng-modules-dkms issues "depmod -a" after the make
> > modules_install ?

Yeah it does, it runs it once at the end after all modules have been
compiled.

In Somanath's original email, there are two sessiond running, one as
root and one as the user. I'm curious as to how the user one got
started, perhaps the commands weren't executed as root somehow?


Cheers,
-- =

Alexandre Montplaisir
DORSAL lab,
=C9cole Polytechnique de Montr=E9al

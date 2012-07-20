From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng
Date: Fri, 20 Jul 2012 10:56:14 -0400
Message-ID: <5009718E.8020308__47356.8303430968$1342796275$gmane$org@efficios.com>
References: <C3E76F4DB674C24BA475182F42DDE8B54E5ACE@SOM-EXCH02.nuance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SsEcq-0006zS-W1
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 10:56:17 -0400
In-Reply-To: <C3E76F4DB674C24BA475182F42DDE8B54E5ACE@SOM-EXCH02.nuance.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Alawneh, Luay" <Luay.Alawneh@nuance.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Luay,

I am not aware of any Log4c --> LTTng transition work done up to this
day...

One thing I can say is that user space tracing using LTTng will
certainly improve speed and scalability performance.

The event LOGLEVEL feature is pretty interesting for that where you
can only enable a certain loglevel facility for a trace (exactly like
the syslog facilities). You can refer to the lttng-ust(3) man page for
more information.

Moreover, you can also couple kernel traces to your user space traces
which can give you way more information :).

I guess that if now one replies to this thread describing their
experience with log4c vs lttng, you guys will be the first to try a
transition and we will be more than happy to help you with any bugs or
difficulties you'll encounter :)

Moreover, if you are able to come up with some sort of scripts/recipe
for that, it will be the kind of documentation or tool that could
benefit big time the community! :)

Feel free to ask on the mailing list any concerns/questions/comments
you have.

Cheers!
David

Alawneh, Luay:
> Hi,
> 
> 
> 
> I am reading about LTTng and I would like to know if it can
> replace Log4c for logging user space events in the production
> environment. In addition to the method enter/exit events we also
> use Log4c to log many other events to indicate errors and other
> useful information.
> 
> 
> 
> To summarize, I would like to know if LTTng can be used in a
> production environment for logging different types of events. We
> are planning to replace Log4c with another logging framework to
> improve the performance by reducing the time spent in logging.
> 
> 
> 
> Thanks,
> 
> 
> 
> Luay Alawneh
> 
> Nuance Communications
> 
> 
> 
> 
> 
> This body part will be downloaded on demand.
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQCXGLAAoJEELoaioR9I02u0YH/3MGDZJuzI6iTh4oVvXGeoAl
NkKjNOU6c/vrsPbys+sNnlczg8CyezT6nL8DOeLkhg/HBAS6JtJngULOwBaSiNV3
J4/SD6Y/Fa96oJnOR5pLUBVdLxrkdOhPvwEiUd2L1DIugrZKJ8pTxs28lX59ltq+
3s59b20pJw9hNEHeDRc7MUY5fEa6t0FNYONsnYqUEEyLeZwYydHz1offgTG2dAhC
FzUCsG1Xzq2TT5PkA/M9ZNu3YQlDJOOzPOY/9A+O9rI5993iAab/lZ/jaDAgZZ0j
4JpHzJGjaqF0XuY+3FpfoPC/DFqBBEjnzXzBTUQahmX7KjzqmdxQIwBiiiloMHg=
=Z97t
-----END PGP SIGNATURE-----

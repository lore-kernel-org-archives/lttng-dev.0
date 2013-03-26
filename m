From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Pull request: lttng-ust tests clean-up
Date: Tue, 26 Mar 2013 09:48:52 -0400
Message-ID: <20130326134852.GA14753__10812.05630112$1364305792$gmane$org@Krystal>
References: <CA+jJMxteq8pb2CjCLVEBLFoXAdfWDX_djLfUxrQ9ad_UiYh5cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKUFE-000202-9L
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 09:48:56 -0400
Content-Disposition: inline
In-Reply-To: <CA+jJMxteq8pb2CjCLVEBLFoXAdfWDX_djLfUxrQ9ad_UiYh5cA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Hi all,
> =

> I'd like to propose a set of patches to clean-up the lttng-ust tests.
> Since the clean-up now weighs in at a fairly hefty 21 patches, I think
> a link to my personal repository might be more appropriate than
> posting the patch-set on this list.
> =

> The relevant commits are 8ae5122...0060eb2
> =

> I will also be posting a set of patches that fixes and moves some of
> the lttng-ust tests to lttng-tools since they depend on it.
> =

> Git access:
> git://github.com/jgalar/lttng-ust-tests-cleanup.git  -b test-cleanup
> =

> Web interface:
> https://github.com/jgalar/lttng-ust-tests-cleanup

I tried running the various batch files under tests/ in your tree, and
they pretty much all complain about:

compudj@thinkos:~/git/jgalar/lttng-ust-tests-cleanup/tests$
(git:test-cleanup)> ./runtests =

./runtests: line 31: .//snprintf/run: No such file or directory

Is that expected ?

Also, make check only runs a single test:

snprintf/test_snprintf .. ok   =

All tests successful.
Files=3D1, Tests=3D1,  0 wallclock secs ( 0.01 usr +  0.00 sys =3D  0.01 CP=
U)
Result: PASS

Is that expected too ?

Thanks,

Mathieu

> =

> Comments are welcome, as always!
> =

> Regards,
> J=E9r=E9mie
> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

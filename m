From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Pull request: lttng-ust tests clean-up
Date: Tue, 26 Mar 2013 10:48:19 -0400
Message-ID: <CA+jJMxsk-JcPROObmKEtH1J+p_ArxwhXHp0yYcg1Xsu6DGDrpw__32973.5007755973$1364309371$gmane$org@mail.gmail.com>
References: <CA+jJMxteq8pb2CjCLVEBLFoXAdfWDX_djLfUxrQ9ad_UiYh5cA@mail.gmail.com>
	<20130326134852.GA14753@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UKVAo-0002VF-6M
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 10:48:26 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so974390wid.6
	for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2013 07:48:20 -0700 (PDT)
In-Reply-To: <20130326134852.GA14753@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 26, 2013 at 9:48 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
>> Hi all,
>>
>> I'd like to propose a set of patches to clean-up the lttng-ust tests.
>> Since the clean-up now weighs in at a fairly hefty 21 patches, I think
>> a link to my personal repository might be more appropriate than
>> posting the patch-set on this list.
>>
>> The relevant commits are 8ae5122...0060eb2
>>
>> I will also be posting a set of patches that fixes and moves some of
>> the lttng-ust tests to lttng-tools since they depend on it.
>>
>> Git access:
>> git://github.com/jgalar/lttng-ust-tests-cleanup.git  -b test-cleanup
>>
>> Web interface:
>> https://github.com/jgalar/lttng-ust-tests-cleanup
>
> I tried running the various batch files under tests/ in your tree, and
> they pretty much all complain about:
>
> compudj@thinkos:~/git/jgalar/lttng-ust-tests-cleanup/tests$
> (git:test-cleanup)> ./runtests
> ./runtests: line 31: .//snprintf/run: No such file or directory
>
> Is that expected ?
>

I meant to remove that file since, with Christian's recent lttng-tools
patches, we moved away from using runner scripts to using prove + test
lists. I'll correct the last commit (Tests: Use Perl prove as the
testsuite runner).

> Also, make check only runs a single test:
>
> snprintf/test_snprintf .. ok
> All tests successful.
> Files=3D1, Tests=3D1,  0 wallclock secs ( 0.01 usr +  0.00 sys =3D  0.01 =
CPU)
> Result: PASS
>
> Is that expected too ?

Yes, most of the tests were moved to lttng-tools since they depend on
lttng-sessiond. Hopefully, now that the infrastructure is in place,
It'll be easier to add self-contained UST tests.

I'll take the opportunity to ask if you, or anyone else really, have
suggestions for UST unit tests that don't depend on lttng-tools?

I can think of a few, such as validating the header files outputted by
lttng-gen-tp, testing the filter bytecode interpretation mechanisms,
etc. But I wonder if unit testing the control interface, for instance,
is realistic since it tends to change fairly often. Of course, lttng
contributors are welcome to submit new tests!

As for my lttng-tools patches, some of the new tests depend on the
lttng-tools python bindings (not included in the default
configuration). I'm wondering what woud be the best way to get tests
to run conditionally depending on the "configure" options now that we
are using Christian's "prove + test lists" scheme.

I have discussed the issue with him privately and we both agreed that
we could have separate test lists that would be used depending on the
current project configuration. While this would certainly be good
enough for now, manually maintaining test lists based on configuration
dependancies may grow tedious as we add configuration options and
tests.

Perhaps we could dynamically generate test lists depending on the
configuration options and each tests' requirements... but that
certainly sounds like overkill right now. Thoughts?

J=E9r=E9mie

>
> Thanks,
>
> Mathieu
>
>>
>> Comments are welcome, as always!
>>
>> Regards,
>> J=E9r=E9mie
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

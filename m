From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Running lttng-tools tests?
Date: Mon, 8 Jul 2013 11:43:13 -0400
Message-ID: <20130708154313.GJ29362__48342.9091204472$1373298234$gmane$org@Krystal>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D21ECF@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CAGDH53k36vdDRECSym0s8WHAK33ZrMmCVwT4OJt-8kwxmCwQsQ@mail.gmail.com>
	<48CF5AC71E61DB46B70D0F388054EFFD12D22366@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwDau-00069S-HY
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 11:43:16 -0400
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D22366@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    I tried deploying the tarball to another directory and building.  The =
tests refuse to run ("Could not execute (unit/test_kernel_data): open3: exe=
c of unit/test_kernmel_data failed at /usr/share/perl/5.14/TAP/Parser/Itera=
tor/Process.pm line 168") until after the make step (naturally).  This time=
 I got:
> =

> unit/test_kernel_data .............. ok
> unit/test_session .................. ok
> unit/test_uri ...................... Dubious, test returned 1 (wstat > 25=
6, 0x100)
> Failed 1/11 subtests
> unit/test_ust_data ................. ok
> unit/test_utils_parse_size_suffix .. ok
> =

> Test Summary Report
> -------------------
> unit/test_uri                    (Wstat: 256 Tests: 11 Failed: 1)
>   Failed test:  4
>   Non-zero exit status: 1
> Files=3D5, Tests=3D55,  4 wallclock secs ( 0.13 usr  0.08 sys +  1.34 cus=
r  1.02 csys =3D  2.57 CPU)
> Result: FAIL
> =

>    Now I get exactly the same report in the original /usr/src/... folder =
if I run 'sudo ./run.sh unit_tests' instead of 'sudo ./run.sh unit_tests'. =
 The problem is clearly one of file ownership (a lot of the /usr/src/... fi=
les are root-owned because of the way they were installed).
> =

> ~~~~~~~~~~
>    I was looking into the babeltrace tests as well (cd babeltrace/tests/,=
 ./runall.sh) and I was surprised that every single "succeed" test failed. =
 Investigation revealed that the babeltrace/converter/babeltrace executable=
 was responsible: it fails with "/usr/bin/ld: fatal error: /usr/src/babeltr=
ace-1.1.0/converter/.libs/26622-lt-babeltrace: open: Permission denied" "co=
llect2: ld a retourn=E9 1 code d'=E9tat d'ex=E9cutionn".  Surprisingly, the=
 babeltrace/converter/babeltrace executable is *different* from the /usr/lo=
cal/bin/babeltrace executable (according to diff).  So are the babeltrace-l=
og executables.  The timestamps are four seconds apart.
> =

>    The install log shows nothing strange: "libtool: install: /usr/bin/ins=
tall -c .libs/babeltrace /usr/local/bin/babeltrace".  /usr/bin/install is s=
upposed to do a plain copy, no?
> =

>    Changing runall.sh so it runs the installed /usr/local/bin/babeltrace =
yields successful tests except for the succeed3 trace:
> =

> $ babeltrace /usr/src/babeltrace-1.1.0/tests/ctf-traces/succeed/succeed3
> [error] at line 9: token ""?\x20\o040?"": syntax error, unexpected ERROR
> =

> [error] Error creating AST
> [warning] Unable to open trace metadata for path "/usr/src/babeltrace-1.1=
.0/tests/ctf-traces/succeed/succeed3".
> [warning] [Context] Cannot open_trace of format ctf at path /usr/src/babe=
ltrace-1.1.0/tests/ctf-traces/succeed/succeed3.
> [warning] [Context] cannot open trace "/usr/src/babeltrace-1.1.0/tests/ct=
f-traces/succeed/succeed3" from /usr/src/babeltrace-1.1.0/tests/ctf-traces/=
succeed/succeed3 for reading.
> [error] Cannot open any trace for reading.
> =

> [error] opening trace "/usr/src/babeltrace-1.1.0/tests/ctf-traces/succeed=
/succeed3" for reading.
> =

> [error] none of the specified trace paths could be opened.
> =

>    Here also, ownership is responsible: running 'sudo ./runall.sh' (on th=
e original runall.sh) yields the same successes (and the same succeed3 trac=
e failure).
> =

>    So at this point I have three remaining questions:
> =

> 1) Why does unit/test_uri fail one of its 11 sub-tests?
> 2) Why does babeltrace fail when reading the succeed3 ctf trace?
> 3) Why on Earth are the babeltrace executables tampered with when install=
ed?

ensure that your lttng-sessiond is not running when doing make check on
lttng-tools.

ensure that your files have the proper permissions when installed in
your system, if you plan on using them. You seem to be the only one
having this kind of issue, so it's probably specific to your
distribution setup.

Thanks,

Mathieu

> =

> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0| Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

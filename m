From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Running lttng-tools tests?
Date: Thu, 30 May 2013 18:59:13 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D21ECF__21167.037721216$1369940478$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Ui85R-00064N-TB
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 15:00:33 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

After installing lttng-tools (2.2.0-rc2) in /usr/src, I tried this:

$ cd /usr/src/lttng-tools-2.2.0-rc2/tests
$  ./run.sh unit_tests

   And I got this:

unit/test_kernel_data .............. Dubious, test returned 1 (wstat 256, 0=
x100)
No subtests run =

unit/test_session .................. Dubious, test returned 1 (wstat 256, 0=
x100)
No subtests run =

unit/test_uri ...................... Dubious, test returned 1 (wstat 256, 0=
x100)
No subtests run =

unit/test_ust_data ................. Dubious, test returned 1 (wstat 256, 0=
x100)
No subtests run =

unit/test_utils_parse_size_suffix .. Dubious, test returned 1 (wstat 256, 0=
x100)
No subtests run =


Test Summary Report
-------------------
unit/test_kernel_data            (Wstat: 256 Tests: 0 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
unit/test_session                (Wstat: 256 Tests: 0 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
unit/test_uri                    (Wstat: 256 Tests: 0 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
unit/test_ust_data               (Wstat: 256 Tests: 0 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
unit/test_utils_parse_size_suffix (Wstat: 256 Tests: 0 Failed: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
Files=3D5, Tests=3D0,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.04 cusr  =
0.04 csys =3D  0.11 CPU)
Result: FAIL

   There is no README in lttng-tools/tests (unlike lttng-ust, but sadly lik=
e userspace-rcu), and the script is laconic, so I can't be sure if this is =
a true failure (my installation works) or if I just ran the tests wrong.  F=
or userspace-rcu, I ran ' ./runtests.sh 2 2 10', but I got no PASS/FAIL eva=
luation so I'm not 100% sure the tests were a success.

   How are these tests supposed to be run?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>

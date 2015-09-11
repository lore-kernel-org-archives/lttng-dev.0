From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] Tests: use functions from
	utils.sh
Date: Fri, 11 Sep 2015 13:03:31 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD8F0D9827__864.902875810181$1441976690$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1ZaNzN-0003lv-IF
 for lttng-dev@lists.lttng.org; Fri, 11 Sep 2015 09:03:38 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "jgalar@efficios.com" <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

------------------------------
Date: Thu, 10 Sep 2015 16:07:47 -0400
From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
@@ -952,6 +952,44 @@ function lttng_untrack_fail()
+function add_context_lttng()
[...]
+	if [[ $expected_to_fail -eq "1" ]]; then
+		test $ret -ne "0"
+		ok $? "Add context command failed as expected"
+	else
+		ok $ret "Add context command success as expected"
+	fi
------------------------------

   To be consistent, the second message should be:

+		ok $ret "Add context command succeeded as expected"

Daniel U. Thibault, M.Sc.=B2

Scientifique de la d=E9fense, CME-PSC, Centre de recherches de Valcartier
Recherche et d=E9veloppement pour la d=E9fense Canada / Gouvernement du Can=
ada
daniel.thibault@drdc-rddc.gc.ca / T=E9l: 418-844-4000x4245 T=E9l=E9c: 418-8=
44-4538
daniel.thibault@forces.gc.ca / T=E9l: 418-844-4000x4245 T=E9l=E9c: 418-844-=
4538

Defence Scientist, MCCS-SPC, Valcartier Research Centre =

Defence Research and Development Canada=A0/ Government of Canada
daniel.thibault@drdc-rddc.gc.ca / Tel: 418-844-4000x4245 Fax: 418-844-4538
daniel.thibault@forces.gc.ca / Tel: 418-844-4000x4245 Fax: 418-844-4538

DRDC is an agency of the Department of National Defence / RDDC est une agen=
ce du minist=E8re de la D=E9fense nationale

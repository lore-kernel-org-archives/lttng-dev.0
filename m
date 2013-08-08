From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttv] Add build instructions for git tree
 pulls and use more standard formatting
Date: Thu, 8 Aug 2013 15:20:11 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26661385__25902.746912516$1375975269$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V7S0b-0001GP-A3
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 11:20:19 -0400
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
Cc: David Vomlehn <vomlehnd@amazon.com>
List-Id: lttng-dev@lists.lttng.org

------------------------------
Date: Wed, 7 Aug 2013 12:48:53 -0700
From: Vomlehn <vomlehnd@amazon.com>

-- ./configure
-- make
-- make install
+  $ ./configure
+  $ make
+  $ make install
+
+To compile the source tree from a git checkout, use:
+
+  $ autoreconf
+  $ automake --add-missing --gnu
+  $ make
+  $ make install
 =

 After running ./configure, you can also go in specific subdirectories and
 use make, make install.
------------------------------

   Actually, in each instance of 'make install', you'll need to use 'sudo m=
ake install'.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>

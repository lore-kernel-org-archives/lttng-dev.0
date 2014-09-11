From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng-bash_completion
Date: Thu, 11 Sep 2014 17:56:22 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD4EC62D32__6907.20649804479$1410458273$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XS8bo-0007RM-Tb
 for lttng-dev@lists.lttng.org; Thu, 11 Sep 2014 13:56:46 -0400
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
List-Id: lttng-dev@lists.lttng.org

The lttng-tools.git file extras/lttng-bash_completion is incomplete since t=
he addition the load and save commands to LTTng's repertoire.  The missing =
routines (inserted between _lttng_cmd_list() and _lttng_cmd_setsession()) w=
ould be:

_lttng_cmd_load() {
	options=3D$(lttng load --list-options)

	case $cur in
	-*)
		_lttng_complete_options
		return
		;;
	*)
		_lttng_complete_sessions
		return
		;;
	esac
}

_lttng_cmd_save() {
	options=3D$(lttng save --list-options)

	case $cur in
	-*)
		_lttng_complete_options
		return
		;;
	*)
		_lttng_complete_sessions
		return
		;;
	esac
}

   I'll let someone else generate the patch.

   Oh, and there's a bug with those two commands.  See bug #835.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>

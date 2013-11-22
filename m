From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: make a trace_event in a modul (driver)
Date: Fri, 22 Nov 2013 18:54:57 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A5932__9425.99188206277$1385146556$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VjvsY-0005S7-WC
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 13:55:04 -0500
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
List-Id: lttng-dev@lists.lttng.org

> how can I define a "tracing"group , so I no longer need the sudo command?

$ sudo addgroup --system tracing
$ sudo adduser username tracing

You must log off and back on for group membership to be activated.

You may also want to add lttng-sessiond as a service:

$ sudo ln --symbolic /lib/init/upstart-job /etc/init.d/lttng-sessiond

And create /etc/init/lttng-sessiond.conf containing:

description "LTTng central tracing registry session daemon"
author "St=E9phane Graber <stgraber@ubuntu.com>"
start on local-filesystems
stop on runlevel [06]
respawn
exec lttng-sessiond

You can then start the session daemon with 'sudo service lttng-sessiond sta=
rt' (stop it with 'stop', restart with 'restart').

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

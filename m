From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: btrfs tracepoint oddity
Date: Thu, 16 Oct 2014 13:48:42 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5A2447C1__14775.9248772219$1413467371$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XelQ8-0008SA-Aj
 for lttng-dev@lists.lttng.org; Thu, 16 Oct 2014 09:48:50 -0400
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

   Something odd happens when I build lttng-modules (2.5.0-9) with an enric=
hed linux-headers package (I added the btrfs, ext3, and ext4 file system he=
aders from the Linux source): one of the btrfs events has a strange name.

$ sudo -H lttng list -k
[...]
btrfs_ordered_extent_start
btrfs_ordered_extent_put
__extent_writepage
btrfs_writepage_end_io_hook
btrfs_sync_file
[...]

   This can be traced to include/trace/events/btrfs.h (in the Linux kernel =
source), which has:

[...]
DEFINE_EVENT(btrfs__writepage, __extent_writepage,
[...]

instead of

[...]
DEFINE_EVENT(btrfs__writepage, btrfs_extent_writepage,
[...]

   This is a minor annoyance (it does not impede LTTng from functioning) th=
at I suppose needs to be handled upstream?  No other kernel tracepoint seem=
s to have an out-of-joint name.

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

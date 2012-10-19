From: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Subject: Flight-recorder mode
Date: Fri, 19 Oct 2012 08:07:41 +0000
Message-ID: <524C960C5DFC794E82BE548D825F05CF5BC75AB2__35707.4360283606$1350634103$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Fredrik_Oestman@mentor.com>) id 1TP7cU-00020Q-1V
	for lttng-dev@lists.lttng.org; Fri, 19 Oct 2012 04:07:50 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TP7cO-0000OX-1C from Fredrik_Oestman@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 19 Oct 2012 01:07:44 -0700
Content-Language: en-US
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

Hi,


We use LTTng 2.0 with a limited file system on the target to receive the tr=
ace logs:

  Extract of fstab file:
  tmpfs        /dev/shm    tmpfs  size=3D64M,mode=3D777,noauto            0=
   0

When tmpfs is full, trace logs are corrupted. Since it is very difficult to=
 control the tracing to avoid this, we would need a real flight-recorder mo=
de where the files on the disk have a pre-defined (maximum) size and where =
either discard or overwrite mode can be applied.

Is there such a thing or some other solution to the problem?


Cheers,

Fredrik =D6stman

http://go.mentor.com/sourceryanalyzer/

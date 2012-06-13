From: John Steele Scott <toojays@toojays.net>
Subject: urcu commit a767fd requires autoconf >= 2.64.
Date: Wed, 13 Jun 2012 16:34:42 +0930
Message-ID: <jr9e2h$phq$1__9401.2307854884$1339571146$gmane$org@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from plane.gmane.org ([80.91.229.3])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1Sehdg-0000rO-5Z
	for lttng-dev@lists.lttng.org; Wed, 13 Jun 2012 03:05:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1SehdZ-0000Gv-Dq
	for lttng-dev@lists.lttng.org; Wed, 13 Jun 2012 09:05:08 +0200
Received: from 146.174.200.100 ([146.174.200.100])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Wed, 13 Jun 2012 09:05:05 +0200
Received: from toojays by 146.174.200.100 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Wed, 13 Jun 2012 09:05:05 +0200
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

http://lists.lttng.org/pipermail/lttng-dev/2012-May/017927.html

I tried to build the latest urcu (git master e51500) on a Centos 6.2 box, and got:

jscott@dxi0-62:~/src/userspace-rcu$ make -j4
CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run aclocal-1.11 -I config
CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run autoconf
 cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run automake-1.11 --foreign
configure:4010: error: possibly undefined macro: m4_ifnblank
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
make: *** [configure] Error 1
make: *** Waiting for unfinished jobs....

Some digging showed that the macro m4_ifnblank requires autoconf 2.64. Centos 6.2 has autoconf 2.63. :(

I just worked around it by reverting commit a767fd locally, then I can build fine.

cheers,

John

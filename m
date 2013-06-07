From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Compiliing LTTng-modules 2.1 with a 3.9.4 kernel
Date: Fri, 07 Jun 2013 14:05:39 -0400
Message-ID: <51B220F3.70901__47320.8567513668$1370628383$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Ul12o-0004DE-VD
	for lttng-dev@lists.lttng.org; Fri, 07 Jun 2013 14:05:47 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so7610897iec.9
	for <lttng-dev@lists.lttng.org>; Fri, 07 Jun 2013 11:05:41 -0700 (PDT)
Received: from [132.207.72.30] (dyn30.dorsal.polymtl.ca. [132.207.72.30])
	by mx.google.com with ESMTPSA id
	qn10sm17856294igc.6.2013.06.07.11.05.40
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 07 Jun 2013 11:05:40 -0700 (PDT)
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

Hi all,

I've cherry-picked the necessary fixes to build the 2.1 version of the
lttng-modules and I've put them in this branch:

http://git.dorsal.polymtl.ca/~ybrosseau?p=lttng-modules.git;a=shortlog;h=refs/heads/stable-2.1-3.9

You can get it with this git clone command:
git clone -b stable-2.1-3.9
git://git.dorsal.polymtl.ca/~ybrosseau/lttng-modules.git

Mathieu, maybe you can consider putting them in the stable-2.1 official
branch.

Yannick

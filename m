From: "Tetreault, Francois" <ftetreau@ciena.com>
Subject: Suggestions concerning lttng analyses
Date: Wed, 6 Jan 2016 15:09:33 -0500
Message-ID: <86064E213FDE854885686AF0C4584029A95728DB55__38664.369021035$1452111036$gmane$org@ONWVEXCHMB02.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-00103a01.pphosted.com ([67.231.152.227])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=4813206aeb=ftetreau@ciena.com>)
 id 1aGuOo-0005GT-28
 for lttng-dev@lists.lttng.org; Wed, 06 Jan 2016 15:09:38 -0500
Received: from pps.filterd (m0002317.ppops.net [127.0.0.1])
 by mx0b-00103a01.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
 u06K6rTU010560
 for <lttng-dev@lists.lttng.org>; Wed, 6 Jan 2016 15:09:36 -0500
Received: from vawvcgsie2k1302.ciena.com (lin1-118-36-36.ciena.com
 [63.118.36.36])
 by mx0b-00103a01.pphosted.com with ESMTP id 206bnhbh90-1
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 06 Jan 2016 15:09:36 -0500
Content-Language: en-US
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

Some comments concerning lttng analyses.

1- How to figure which version of the lttng analyses package is installed?
1.1- Version is "0-unknown" when using "pip3 show lttnganalyses".
         Would be nice to get this fixed.
         /usr/local/bin$ sudo pip3 show lttnganalyses
         ---
         Name: lttnganalyses
         Version: 0-unknown
         Location: /usr/local/lib/python3.4/dist-packages
         Requires:
1.2- Is there another way to get the version?

2- Cannot find python3-lttnganalyses using apt on XUbuntu 14.04.03
2.1- Followed instructions as provided in lttng analyses README file
        apt-get install -y software-properties-common (or python-software-properties on 12.04)
        apt-add-repository -y ppa:lttng/ppa
        apt-get update
        apt-get -y install lttng-tools babeltrace lttng-modules-dkms python3-babeltrace python3-progressbar python3-lttnganalyses

        But python3-lttnganalyses cannot be found.
        /usr/local/bin$ sudo apt search python3 | grep ltt
        brltty/trusty,now 5.0-2ubuntu2 i386 [installed]
        python3-lttng/trusty 2.7.x+stable+bzr2953+pack19+201512081531~ubuntu14.04.1 i386
        python3-lttngust/trusty 2.7.x+stable+bzr1923+pack63+201512012316~ubuntu14.04.1 all

        Had to resort to pip3 method and that worked.
        pip3 install lttnganalyses


Thank you,
Francois

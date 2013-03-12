From: Josh Stone <jistone@redhat.com>
Subject: Re: [lttng-tools PATCH] Correct LTTng version
Date: Tue, 12 Mar 2013 14:54:30 -0700
Message-ID: <513FA416.1040106__31339.0523115688$1363125322$gmane$org@redhat.com>
References: <14dbf3b61272282c1f4163c8a1a2f2b681f3989c.1363123481.git.raphael.beamonte@gmail.com>
	<513F9DF1.9030909@efficios.com>
	<CAE_Gge0+ympRPULDhugMjFCxDrs49t3wJy9BRbOUYNkyfCoU_A@mail.gmail.com>
	<513F9F81.9040909@gmail.com> <513FA045.401@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jistone@redhat.com>) id 1UFX9Y-0003fz-HE
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 17:54:36 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2CLsUT1015929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 17:54:30 -0400
Received: from [10.3.113.10] ([10.3.113.10])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id r2CLsU3P024817
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 17:54:30 -0400
In-Reply-To: <513FA045.401@efficios.com>
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

On 03/12/2013 02:38 PM, David Goulet wrote:
> Yup that would be ideal actually!
> 
> Master is not 2.0 nor 2.1 so having something like
> "git-FIRST_8_BYTES_OF_HEAD_COMMIT" would be very useful.

You might like this script we use with systemtap:

http://sourceware.org/git/gitweb.cgi?p=systemtap.git;a=blob;f=git_version.sh

That gives us a header which defines a git version string such as
"release-2.1-78-g3d0a328", in the style of "git describe".

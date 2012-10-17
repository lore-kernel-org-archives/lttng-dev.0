From: Josh Stone <jistone@redhat.com>
Subject: Re: are LTTng-2.0 packages available on Fedora 16 via
 yum?
Date: Wed, 17 Oct 2012 09:35:39 -0700
Message-ID: <507EDE5B.8090102__9188.22575263238$1350491781$gmane$org@redhat.com>
References: <7F632A9222059A42AF70FCB7965774AA2063D880@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jistone@redhat.com>) id 1TOWaw-0008Si-Bj
	for lttng-dev@lists.lttng.org; Wed, 17 Oct 2012 12:35:46 -0400
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA2063D880@ALA-MBB.corp.ad.wrs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

(resending, as I neglected to CC the list...)

On 10/17/2012 04:32 AM, McDermott, Andrew wrote:
> I'm happily using LTTng-2.0 on Ubuntu-12.04 but I was wondering if
> Fedora 16 is supported via a yum install.  I see quite a few references
> to 17 but not necessarily 16.  Is this correct or am I simply not
> searching hard enough.

You can see which packages are available anywhere in Fedora here:
https://apps.fedoraproject.org/packages/lttng-tools
https://apps.fedoraproject.org/packages/lttng-ust

They were just added to Fedora in July, and at that time Yannick only
requested to add f17, so that's why f16 doesn't have them.
https://bugzilla.redhat.com/show_bug.cgi?id=717748#c20
https://bugzilla.redhat.com/show_bug.cgi?id=834481#c4

HTH,
Josh

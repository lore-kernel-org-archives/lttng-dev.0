From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can't get any event output from the demo exe
 [solved]
Date: Fri, 27 Mar 2015 13:52:13 +0000 (UTC)
Message-ID: <2124338345.119592.1427464333584.JavaMail.zimbra__43719.6647435941$1427464419$gmane$org@efficios.com>
References: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924@3capp-gmx-bs44>
 <55073522.6080006@efficios.com>
 <trinity-6a4fab60-3c7e-4785-a2f2-e42bba49fcb4-1426578599498@3capp-gmx-bs25>
 <1948116446.75706.1427119102220.JavaMail.zimbra@efficios.com>
 <trinity-7f4e3d2c-257e-4b0c-92c6-b4db5e00c863-1427125168642@3capp-gmx-bs67>
 <430207063.77873.1427126336840.JavaMail.zimbra@efficios.com>
 <trinity-d22c7eac-b7c9-427b-9b66-822ed9615dc9-1427444856982@3capp-gmx-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YbUgN-0003EZ-5f
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 09:52:25 -0400
In-Reply-To: <trinity-d22c7eac-b7c9-427b-9b66-822ed9615dc9-1427444856982@3capp-gmx-bs08>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wolfgang Rostek <wolfgang.rostek@gmx.de>, Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Alexandre, maintainer of the PPA packages, will be
back from vacation in 2 weeks.

Perhaps he could look into why you had to explicitly
uninstall packages before installing the PPA then.
Normally "conflicts with" should be taking care
of this kind of dependency.

Thanks,

Mathieu

----- Original Message -----
> Just right before the weekend I could repair it.
> Seems that I had some trouble with the installed packages.
> 
> Here the steps working for me on Ubuntu 14 LTS
> 
> http://installion.co.uk/ubuntu/utopic/universe/l/lttng-tools/uninstall/index.html
> sudo apt-get remove --auto-remove lttng-tools
> 
> https://launchpad.net/~lttng/+archive/ubuntu/ppa
> sudo apt-add-repository ppa:lttng/ppa
> sudo apt-get update
> sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
> liblttng-ust-dev python3-babeltrace
> 
> thanks for your investigations
> Wolfgang R.
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

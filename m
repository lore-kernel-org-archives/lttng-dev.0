From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: Suggestions concerning lttng analyses
Date: Wed, 13 Jan 2016 20:45:17 +0000 (UTC)
Message-ID: <1160894423.345288.1452717917128.JavaMail.zimbra__21413.6021364995$1452717984$gmane$org@efficios.com>
References: <86064E213FDE854885686AF0C4584029A95728DB55@ONWVEXCHMB02.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aJSIG-0001oB-KP
 for lttng-dev@lists.lttng.org; Wed, 13 Jan 2016 15:45:25 -0500
In-Reply-To: <86064E213FDE854885686AF0C4584029A95728DB55@ONWVEXCHMB02.ciena.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Tetreault, Francois" <ftetreau@ciena.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- On Jan 6, 2016, at 3:09 PM, Tetreault, Francois ftetreau@ciena.com wrote:
> Some comments concerning lttng analyses.
> 
> 1- How to figure which version of the lttng analyses package is installed?
> 1.1- Version is "0-unknown" when using "pip3 show lttnganalyses".
>         Would be nice to get this fixed.
>         /usr/local/bin$ sudo pip3 show lttnganalyses
>         ---
>         Name: lttnganalyses
>         Version: 0-unknown
>         Location: /usr/local/lib/python3.4/dist-packages
>         Requires:
> 1.2- Is there another way to get the version?

If you install from a git url instead of github's auto tarball url, you'll get a proper
version number :

  pip install --upgrade git+git://github.com/lttng/lttng-analyses.git

I'll update the README with this url.

> 
> 2- Cannot find python3-lttnganalyses using apt on XUbuntu 14.04.03
> 2.1- Followed instructions as provided in lttng analyses README file
>        apt-get install -y software-properties-common (or python-software-properties on
>        12.04)
>        apt-add-repository -y ppa:lttng/ppa
>        apt-get update
>        apt-get -y install lttng-tools babeltrace lttng-modules-dkms python3-babeltrace
>        python3-progressbar python3-lttnganalyses
> 
>        But python3-lttnganalyses cannot be found.
>        /usr/local/bin$ sudo apt search python3 | grep ltt
>        brltty/trusty,now 5.0-2ubuntu2 i386 [installed]
>        python3-lttng/trusty 2.7.x+stable+bzr2953+pack19+201512081531~ubuntu14.04.1 i386
>        python3-lttngust/trusty 2.7.x+stable+bzr1923+pack63+201512012316~ubuntu14.04.1
>        all
> 
>        Had to resort to pip3 method and that worked.
>        pip3 install lttnganalyses
> 

I've recently uploaded lttnganalyses packages in all PPAs for precise and trusty,
have a look and please report any problem you may encounter.

Michael

From: Christoph Egger <christoph@debian.org>
Subject: Re: Package liburcu fix for kfreebsd-amd64 and kfreebsd-i386
Date: Sat, 02 Mar 2013 12:07:01 -0800
Message-ID: <87bob1ftwa.fsf@mitoraj.siccegge.de>
References: <20130222134515.GA22069@Krystal>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <bounce-debian-bsd=debian-bsd=m.gmane.org@lists.debian.org>
In-Reply-To: <20130222134515.GA22069@Krystal>
	(sfid-20130222_145406_989084_516874D5) (Mathieu Desnoyers's message of
	"Fri, 22 Feb 2013 08:45:15 -0500")
Resent-Message-ID: <IfDwbfAHQqL.A.X0H.DwlMRB@bendel>
List-URL: <http://lists.debian.org/debian-bsd/>
List-Post: <mailto:debian-bsd@lists.debian.org>
List-Help: <mailto:debian-bsd-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bsd-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bsd-request@lists.debian.org?subject=unsubscribe>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: debian-bsd@lists.debian.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> I noticed failures to build for the liburcu Debian package for
> kfreebsd-amd64 and kfreebsd-i386. I just pushed a commit into the master
> branch that should solve the build errors encountered. Would it be
> possible to test a build of Userspace RCU master branch against those
> two architectures ? If it works fine, then I could backport this commit
> into the stable-0.7 branch.

Where do I get this master branch? debcheckout doesn't. Also, please
direct this request to the porter list (Cc-ed) giving more people a
chance to repond.

    Christoph

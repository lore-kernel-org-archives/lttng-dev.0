From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: Odd dependency for lttng-ust - resolved
Date: Fri, 25 Jan 2013 13:48:28 -0500
Message-ID: <CAGDH53nScT2=KHr=P_tdDA-rSAnNvfga0V9Q_K4aA3JD06Shpg__938.866337719624$1359139795$gmane$org@mail.gmail.com>
References: <3CA1A65C03C1A34C81BBC6272782E696987A76@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<5102C77A.5040409@voxpopuli.im>
	<3CA1A65C03C1A34C81BBC6272782E696987A7F@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TyoKI-0002G6-1Z
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 13:48:34 -0500
Received: by mail-ie0-f171.google.com with SMTP id 9so134867iec.2
	for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2013 10:48:28 -0800 (PST)
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987A7F@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

>    Nope, my /usr/lib is clean.  The problem is unavoidable on a clean system because lttng-tools's README lists GNU Gold (2.22 or better) in its requirements when building from git.  On the other hand, if you had a liburcu package installed and it were not too old, configure's checks would be passed.  You could run into trouble during the make though, depending on which liburcu (/usr/lib vs. /usr/local/lib) it linked against.  But that scenario is moot as Mathieu rightly warned against mixing old and new stuff together.

The README has been clarified in commit
ee10cdeb41ab238ebdc9ae3d1b2a4dbbe930df9b.

The bottom line is:

With GNU ld: ./configure *should* work as is if "/usr/local/lib" is
correctly specified in /etc/ld.so.conf. Note that this is
_distribution specific_ and you might have to use
LDFLAGS=-L/usr/local/lib ./configure on other distros.

With GNU Gold: Use LDFLAGS=-L/usr/local/lib ./configure if
dependencies have been installed in /usr/local/*.

Thanks,

Christian

From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Issue with UST tracing - unable to view CTF traces
Date: Fri, 28 Mar 2014 16:06:28 +0000
Message-ID: <7dc17672df8141e3af8a275931834909__48150.6694377915$1396022866$gmane$org@Perses.usurf.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from echo.usurf.usu.edu ([129.123.194.129])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.Haws@sdl.usu.edu>) id 1WTZIx-0001ql-L0
 for lttng-dev@lists.lttng.org; Fri, 28 Mar 2014 12:06:52 -0400
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

I am having a problem with UST tracing on my system.  My setup is as follows:

I have my development system running Xubuntu 12.04 LTS with the LTTng ppa enabled, so I am running the 2.4.0 tools.  I have my embedded target running manually compiled 2.4.0 tools (it's distro is Fedora 17 right now).

Last week things were working just fine, but I made some changes to my template file and something broke, but I can't figure out what is up.


When I try to import traces into the Eclipse tools, I get the following error:

org.eclipse.linuxtools.tmf.core.exceptions.TmfTraceException: MismatchedTokenException(LPAREN!=TERM) at metadata:204


When I try to open with babeltrace, I get the following:

jhaws@verde:~/trace$ babeltrace sms/SMS-20110922-130857/ust
[error] at line 199: token "(": syntax error, unexpected LPAREN, expecting SEMICOLON or COMMA

[error] Error creating AST
[warning] Unable to open trace metadata for path "sms/SMS-20110922-130857/ust/uid/0/64-bit".
[warning] [Context] Cannot open_trace of format ctf at path sms/SMS-20110922-130857/ust/uid/0/64-bit.
[warning] [Context] cannot open trace "sms/SMS-20110922-130857/ust/uid/0/64-bit" from sms/SMS-20110922-130857/ust for reading.
[error] Cannot open any trace for reading.

[error] opening trace "sms/SMS-20110922-130857/ust" for reading.

[error] none of the specified trace paths could be opened.


What am I doing wrong?  Things were working great before, but now something is up. What are the chances that there is a compatibility issue between the two installations?

Thanks!
Jon

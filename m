From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Trace just the my application processes
Date: Mon, 17 Mar 2014 22:38:00 +0000
Message-ID: <9531e427eaa14e45a70927ac5e8643dd__7728.1117359691$1395095959$gmane$org@Perses.usurf.usu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from echo.usurf.usu.edu ([129.123.194.129])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Jonathan.Haws@sdl.usu.edu>) id 1WPgAf-0002e8-Kr
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 18:38:19 -0400
Content-Language: en-US
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

I'm sure this question has been asked, but no amount of searching has helped so far...

I have a suite of programs that I would like to enable tracing for and be able to view the control flow, statistics, etc. in the Eclipse plugin.  How is this done?  I have instrumented my code for UST and enabled all the necessary kernel events and I get good trace data, but I would like to prefilter all the stuff not associated with my processes.  If the data is there, that is fine (I will probably want it) but is there any way to capture data on just the desired processes?  What about being able to hide things in the Control Flow view?

Thanks!
Jon

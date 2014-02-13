From: Olivier Cotte <olivier.cotte@polymtl.ca>
Subject: Re: Machine Interface
Date: Thu, 13 Feb 2014 13:00:17 -0500
Message-ID: <52FD0831.7030704__12077.5816416883$1392314487$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842722334=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <olivier.cotte@polymtl.ca>) id 1WE0aC-0001oz-8p
	for lttng-dev@lists.lttng.org; Thu, 13 Feb 2014 13:00:25 -0500
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

This is a multi-part message in MIME format.
--===============0842722334==
Content-Type: multipart/alternative;
 boundary="------------000906080400090604070007"

This is a multi-part message in MIME format.
--------------000906080400090604070007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

At first, we wanted thank you for your quick and constructive feedback!

After reflection on the nature of the problem and consideration of your feedback, we've arrived with the following solution.

The technology that will be use is XML. The integration of the machine interface to LTTng will be done in the most modular manner to facilitate the support multiples outputs format. This option will most likely be available at configure time.

For the moment, we will focus our effort into adding the XML feature only. If many outputs languages is still a viable feature, it will be possible to investigate.

Our main goal is of course to promote extensibility, ease of development for new tools and establish a standards for the communication control flow. Here are our primary requirement concerning the machine interface:

   * Fit the tree structure of LTTng commands structures.
   * It can be parse from bash/shell script with no external helpers.
   * The new format must not introduce any dependencies to LTTng.
   * [Optional] Still human readable, but fit to be parse.This is not a
      priority since we are talking about a machine interface.

Here are the reason why we think XML should be used for the machine interface:

   * The expression of LTTng hierarchy really fit a XML tree structure.
   * Since Jgalar add a load-save feature that depend on libxml2, we are
     not introducing any dependencies. Choosing another format would
     most likely introduce new dependency.
   * XML is robust and easily extensible. It will also be easy to
     maintains (add new commands, modify existing commands etc.)
   * There are tools that allow you to evaluate XPath expressions from
     the bash.
   * XML is an established standard

That's why we consider XML format as a suitable solution.

Now for the machine interface syntax:

   * Since we are aware that multiple output could be supported, we want an
     unify flag for all machine interface command.
		The flag --xml would be used to output xml from LTTng (we could add similar
		options like --json, --yaml etc.). This would be similar to svn
		machine interface and speak for itself.
   * Also, to avoid confusion we will use a different primary command for input and
     output machine interface.
		Ex: lttng machine <input>
		Ex: lttng --xml <output>

Any points we are missing?


--------------000906080400090604070007
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre wrap=""><font face="serif">At first, we wanted thank you for your quick and constructive feedback!

After reflection on the nature of the problem and consideration of your feedback, we've arrived with the following solution.

The technology that will be use is XML. The integration of the machine interface to LTTng will be done in the most modular manner to facilitate the support multiples outputs format. This option will most likely be available at configure time.

For the moment, we will focus our effort into adding the XML feature only. If many outputs languages is still a viable feature, it will be possible to investigate.

Our main goal is of course to promote extensibility, ease of development for new tools and establish a standards for the communication control flow. Here are our primary requirement concerning the machine interface:

  * Fit the tree structure of LTTng commands structures.
  * It can be parse from bash/shell script with no external helpers.
  * The new format must not introduce any dependencies to LTTng.
  * [Optional] Still human readable, but fit to be parse.This is not a 
     priority since we are talking about a machine interface.

Here are the reason why we think XML should be used for the machine interface:

  * The expression of LTTng hierarchy really fit a XML tree structure.
  * Since Jgalar add a load-save feature that depend on libxml2, we are
    not introducing any dependencies. Choosing another format would
    most likely introduce new dependency.
  * XML is robust and easily extensible. It will also be easy to
    maintains (add new commands, modify existing commands etc.)
  * There are tools that allow you to evaluate XPath expressions from
    the bash.
  * XML is an established standard

That's why we consider XML format as a suitable solution.

Now for the machine interface syntax:

  * Since we are aware that multiple output could be supported, we want an
    unify flag for all machine interface command.
		The flag --xml would be used to output xml from LTTng (we could add similar
		options like --json, --yaml etc.). This would be similar to svn
		machine interface and speak for itself.
  * Also, to avoid confusion we will use a different primary command for input and
    output machine interface.
		Ex: lttng machine &lt;input&gt;
		Ex: lttng --xml &lt;output&gt;

Any points we are missing?
</font></pre>
    <font face="serif">
    </font>
  </body>
</html>

--------------000906080400090604070007--


--===============0842722334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0842722334==--

<%@ page language="java" contentType="text/html; charset=GBK" %>

<%@ page import="java.net.URL"%>

<%@ page import="java.net.URLClassLoader"%>

<%@ page import="java.util.Enumeration"%>

<!--  define function in jsp by can_do -->

<%!

private static String getPackageName(Object obj) {

           return getPackageName(obj.getClass());

         }

         private static String getPackageName(Class clazz) {

           Package pack = clazz.getPackage();

           if (pack != null) {

             return pack.getName();

           }

           return null;

         }

%>

 

 

<html>

<head>

<title>retrieve class loader information</title>

<meta name="Generator" content="EditPlus">

<meta name="Author" content="">

<meta name="Keywords" content="">

<meta name="Description" content="">

</head>

 

<body>

 

 <form name="uploadform" action="./checkClassLoader.jsp"  method="post">       

 <%

String strClassFullPath=request.getParameter("className");

 

strClassFullPath=strClassFullPath==null?"":strClassFullPath;

%>

<input type="text" name="className" size="100" value="<%=strClassFullPath%>" /><br>

<%

String strClassLoadedNotFoundClassLoaderContent = "The specified class has  been loaded,but not find its class loader,try other retrieving class loader method.";

String strClassLoadedNotFoundClassLoader="<font color='red' size='5'>"+strClassLoadedNotFoundClassLoaderContent+"</font><br>";

String strClassNotFoundContent="The specified class has NOT been loaded.please check whether it is existing or not. Maybe you misspell the class package or name.";

String strClassNotFound="<font color='red' size='5'>"+strClassNotFoundContent+"</font><br>";

 

Boolean isClassNotFound = false;

if (strClassFullPath==null ||strClassFullPath.trim().length()==0) {

out.println("please input your reviewed class full name.<br>");

}else{

       Class specifiedClass = null;

       ClassLoader strClassLoaderName = null;

       URL oUrl = null;

       URL url = null;

       try {

     specifiedClass = Class.forName(strClassFullPath);

       } catch (NullPointerException e) {

       //e.printStackTrace();

       System.err.println(strClassLoadedNotFoundClassLoaderContent);              

       } catch (ClassNotFoundException e) {

    System.err.println(strClassNotFoundContent);

       isClassNotFound = true;

       }

 

if (!isClassNotFound) {

strClassLoaderName = specifiedClass.getClassLoader();

 

 

String className = specifiedClass.getName();

 

String fileName = String.valueOf(String.valueOf(className.substring(className.lastIndexOf('.') + 1))).concat(".class");

int packLength = getPackageName(specifiedClass).length() + 8;

url = specifiedClass.getResource(fileName);

}

 

if (strClassLoaderName != null) {

oUrl = strClassLoaderName.getSystemResource(strClassFullPath);

 

/////begin//retrieve class's signature information //////

Object signer = specifiedClass.getSigners();

 

              String strSignature = "";

              if (signer != null) {

                     strSignature = signer.toString();

              }

 

out.println("=strSignature is:=" + strSignature + "=end=<br>");

/////end//retrieve class's signature information //////

 

 

///////////begin//////

 

 

 

///////////end//////

 

 

Enumeration en = request==null?null:request.getHeaderNames();

while(en!=null&&en.hasMoreElements()){

       String value = ""+en.nextElement();

       System.out.println("key="+value+":value="+request.getHeader(value));

}

//out.println("=oUrl is:="+(oUrl==null?null:oUrl.toString())+"=end=<br>");

} else {

       out.println((isClassNotFound?strClassNotFound:strClassLoadedNotFoundClassLoader));

}

 

out.println("=System ClassLoader(AppClassloader) is:="+ClassLoader.getSystemClassLoader()+"=end=<br>");

out.println("=AppClassLoader's parent(ExtClassLoader is the topest class loader) is:="+ClassLoader.getSystemClassLoader().getParent()+"=end=<br>");

out.println("=ExtClassLoader's parent is:="+ClassLoader.getSystemClassLoader().getParent().getParent()+"=end=<br>");

out.println("=strClassFullPath is:="+strClassFullPath+"=end=<br>");

out.println("=strClassLoaderName is:="+(strClassLoaderName== null?"":strClassLoaderName.toString())+"=end=<br>");

out.println("=current class's location is:="+(url==null?"":url.toString())+"=end=<br>");

 

}

%>

 

<%

String strUserDir = System.getProperty("user.dir");

String strApusicHome = System.getProperty("com.apusic.home");

String strApusicDomainHome = System.getProperty("com.apusic.domain.home");

out.println("=strUserDir[user.dir] is:="+strUserDir+"=end=<br>");

out.println("=strApusicHome[com.apusic.home] is:="+strApusicHome+"=end=<br>");

out.println("=strApusicDomainHome[com.apusic.domain.home] is:="+strApusicDomainHome+"=end=<br>");

 

//session share test

HttpSession tempSession = request.getSession();

 tempSession.setAttribute("classPackage", strClassFullPath);

 

 boolean isShareContext=true;

 if (isShareContext) {

        System.out.println("do nothing!");

 } else {

        request.getSession().getServletContext().setAttribute("defaultApp", tempSession);

 }

 

 

%>

<input type="submit" name="btSubmit" value="submit">

<p>

for example:

<table>

<tr>

<td>

(1).org.apache.taglibs.i18n.BundleTEI[from WEB-INF/lib]

</td>

<tr>

<td>

(2).com.apusic.welcome.util.MiscUtils[from WEB-INF/classes]

</td>

</tr>

<tr>

<td>

(3).com.apusic.server.Main[from &lt;Apusic_Home&gt;/lib/apusic.jar]

</td>

</tr>

<tr>

<td>

(4).com.apusic.tools.script.shell.Main[from &lt;Apusic_Home&gt;/common/elite-api.jar]

</td>

</tr>

<tr>

<td>

(5).sun.misc.Timer[from &lt;Java_Home&gt;/jre/lib/rt.jar]

</td>

</tr>

</p>

</form>

</body>

</html>
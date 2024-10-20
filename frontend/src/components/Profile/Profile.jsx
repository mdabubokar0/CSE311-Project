import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

export const Profile = () => {
  const [profileMenu, setProfileMenu] = useState(false);
  const navigate = useNavigate();

  const handleProfile = () => {
    setProfileMenu(!profileMenu);
  };

  const trueProfile = () => {
    setProfileMenu(true);
  };

  const falseProfile = () => {
    setProfileMenu(false);
  };

  return (
    <div
      onClick={handleProfile}
      onMouseEnter={trueProfile}
      onMouseLeave={falseProfile}
    >
      <img src="img/profile.png" alt="profile" className="cursor-pointer" />
      {profileMenu && (
        <div className="absolute text-[14px] font-medium flex flex-col gap-3 right-0 bg-[#FAFAFA] p-3 rounded-lg top-[60px] border-[.5px] border-[#c4c4c4]">
          <Link
            to="/editprofile"
            className="flex items-center gap-2 cursor-pointer"
          >
            <img src="img/settings.png" alt="settings" />
            Edit Profile
          </Link>
          <div
            className="flex items-center gap-2 cursor-pointer"
            onClick={() => {
              localStorage.removeItem("token");
              localStorage.removeItem("role");
              navigate("/");
            }}
          >
            <img src="img/logout.png" alt="logout" />
            Logout
          </div>
        </div>
      )}
    </div>
  );
};
